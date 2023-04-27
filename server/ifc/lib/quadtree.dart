import 'package:equatable/equatable.dart';
import 'package:latlng/latlng.dart';

class QuadtreeEntry<T> extends Equatable {
  const QuadtreeEntry(this.location, this.value);
  final LatLng location;
  final T value;

  @override
  get props => [location, value];
}

class _Node<T> {
  _Node(this.center, this.halfRange);
  LatLng center;
  double halfRange;

  /// LatLngBounds can't represent the whole sphere due to a constraint about
  /// 180, so use null for that
  LatLngBounds? get bounds => halfRange >= 180
      ? null
      : LatLngBounds(
          southwest: LatLng(
            center.latitude - halfRange,
            center.longitude - halfRange,
          ),
          northeast: LatLng(
            center.latitude + halfRange,
            center.longitude + halfRange,
          ),
        );

  List<_Node<T>>? children;
  bool get isLeaf => children == null;
  List<QuadtreeEntry<T>> entries = [];

  _Node<T> child(LatLng location) =>
      children![(location.latitude < center.latitude ? 0 : 2) |
          (location.longitude < center.longitude ? 0 : 1)];
}

class Quadtree<T> {
  Quadtree({this.threshold = 8});
  final _Node<T> _root = _Node(const LatLng(0, 0), 180);
  final int threshold;

  int get nodeCount => _nodeCount;
  int _nodeCount = 1;

  void _split(final _Node<T> node) {
    final quarterRange = node.halfRange / 2;
    node.children = List.generate(
      4,
      (i) => _Node(
        LatLng(
            node.center.latitude + (i & 2 == 0 ? -quarterRange : quarterRange),
            node.center.longitude +
                (i & 1 == 0 ? -quarterRange : quarterRange)),
        quarterRange,
      ),
      growable: false,
    );
    for (final entry in node.entries) {
      node.child(entry.location).entries.add(entry);
    }
    // When we split a node, keep a reference to the first entry to stabilize
    // sampling. We'll never split an empty node.
    node.entries = List.unmodifiable(node.entries.take(1));

    _nodeCount += 4;
  }

  void add(LatLng location, T value) =>
      _add(_root, QuadtreeEntry(location, value));

  void _add(_Node<T> node, QuadtreeEntry<T> entry) {
    if (node.isLeaf) {
      if (node.entries.length < threshold) {
        node.entries.add(entry);
        return;
      } else {
        _split(node);
        // TODO(AsturaPhoenix): If more than [threshold] entries share the same
        // location, this won't terminate.
        //
        // The underlying collection could well be a map for our use case, but
        // hashing 100,000 coordinates is probably something we should only do
        // for debug.
      }
    }

    _add(node.child(entry.location), entry);
  }

  /// Resolution is the number of degrees desired between samples. 0 performs no
  /// decimation.
  Iterable<QuadtreeEntry<T>> sample(
    LatLngBounds bounds, {
    double resolution = 0,
  }) =>
      _sample(_root, bounds, adjustedResolution: .75 * resolution);

  /// adjustedResolution is a .75 fudged resolution so that if [node.halfRange]
  /// exceeds it, the node is split, so that the resulting resolution is
  /// centered about the original requested resolution.
  Iterable<QuadtreeEntry<T>> _sample(
    _Node<T> node,
    LatLngBounds? bounds, {
    required double adjustedResolution,
  }) {
    // null means world bounds; see comment on bounds
    if (bounds != null) {
      final nodeBounds = node.bounds;
      // If the node is unbounded, we can't make any simplifications.
      // If the node bounds don't intersect with the requested bounds, skip.
      // If the node bounds fully contain the request bounds, children no longer
      // need to test bounds. This is about a 10% savings.
      if (nodeBounds != null) {
        if (!nodeBounds.intersectsBounds(bounds)) {
          return const [];
        }
        if (bounds.containsBounds(nodeBounds)) {
          bounds = null;
        }
      }
    }

    Iterable<QuadtreeEntry<T>> filterByBounds(
      Iterable<QuadtreeEntry<T>> sample,
    ) =>
        bounds == null
            ? sample
            : sample.where((entry) => bounds!.contains(entry.location));

    if (node.isLeaf) {
      // We could filter by bounds prior to downsampling, but that could yield
      // unstable subsets as the bounds changed. Instead, downsample first and
      // then filter independently.

      // The threshold at which further splitting would be unlikely to help with
      // downsampling. Reasonable values are in the range [1, 4]. Empirically,
      // 4 doesn't seem to help much over 1.
      const minSplitThreshold = 1;

      if (node.halfRange < adjustedResolution) {
        // If the node is near the sampling resolution, use it to downsample.
        // Caution: this makes the results unstable unless entries are sorted in
        // a way consistent with child nodes.
        return filterByBounds(node.entries.take(1));
      } else if (adjustedResolution == 0 ||
          node.entries.length <= minSplitThreshold) {
        // If further splitting would be unlikely to simplify downsampling, just
        // return everything.
        return filterByBounds(node.entries);
      } else {
        _split(node);
      }
    }

    if (node.halfRange < adjustedResolution) {
      // If we're already too small, just take the representative.
      assert(node.entries.length <= 1);
      return filterByBounds(node.entries);
    } else {
      return node.children!.expand(
        (node) => _sample(node, bounds, adjustedResolution: adjustedResolution),
      );
    }
  }
}
