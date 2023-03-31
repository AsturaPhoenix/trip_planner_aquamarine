import 'package:aquamarine_server_interface/src/latlng.dart';
import 'package:test/test.dart';

void main() {
  group('expand', () {
    test('empty inits', () {
      const pt = LatLng(0, 0);
      expect(null.expand(pt), LatLngBounds(southwest: pt, northeast: pt));
    });

    test('northwest from origin', () {
      const start = LatLng(0, 0);
      expect(
        LatLngBounds(southwest: start, northeast: start)
            .expand(const LatLng(45, -90)),
        LatLngBounds(
          southwest: const LatLng(0, -90),
          northeast: const LatLng(45, 0),
        ),
      );
    });

    test('southeast from antipode', () {
      const start = LatLng(0, 180);
      expect(
        LatLngBounds(southwest: start, northeast: start)
            .expand(const LatLng(-45, -90)),
        LatLngBounds(
          southwest: const LatLng(-45, 180),
          northeast: const LatLng(0, -90),
        ),
      );
    });

    test('antipode', () {
      const start = LatLng(0, 0), pt = LatLng(0, 180);
      final expanded =
          LatLngBounds(southwest: start, northeast: start).expand(pt);
      expect(expanded.contains(start), isTrue);
      expect(expanded.contains(pt), isTrue);
      expect(
        (expanded.northeast.longitude - expanded.southwest.longitude) % 360,
        180,
      );
    });

    test('contained noops', () {
      final bounds = LatLngBounds(
        southwest: const LatLng(-45, 90),
        northeast: const LatLng(45, -90),
      );
      final expanded = bounds.expand(const LatLng(0, 180));
      expect(expanded, bounds);
    });
  });

  group('intersects', () {
    void testMutualIntersection(
        LatLngBounds a, LatLngBounds b, Matcher expected) {
      expect(a.intersectsBounds(b), expected);
      expect(b.intersectsBounds(a), expected);
    }

    test('self intersects', () {
      final bounds = LatLngBounds(
        southwest: const LatLng(-2, -2),
        northeast: const LatLng(2, 2),
      );
      testMutualIntersection(bounds, bounds, isTrue);
    });

    test('cross intersects', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(-1, -2),
            northeast: const LatLng(1, 2),
          ),
          LatLngBounds(
            southwest: const LatLng(-2, -1),
            northeast: const LatLng(2, 1),
          ),
          isTrue);
    });

    test('cross across meridian intersects', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(-1, 178),
            northeast: const LatLng(1, -178),
          ),
          LatLngBounds(
            southwest: const LatLng(-2, 179),
            northeast: const LatLng(2, -179),
          ),
          isTrue);
    });

    test('disjoint longitude does not intersect', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(-1, 0),
            northeast: const LatLng(1, 1),
          ),
          LatLngBounds(
            southwest: const LatLng(-1, 2),
            northeast: const LatLng(1, 3),
          ),
          isFalse);
    });

    test('disjoint longitude across meridian does not intersect', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(-1, -1),
            northeast: const LatLng(1, 1),
          ),
          LatLngBounds(
            southwest: const LatLng(-1, 179),
            northeast: const LatLng(1, -179),
          ),
          isFalse);
    });

    test('disjoint latitude does not intersect', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(0, -1),
            northeast: const LatLng(1, 1),
          ),
          LatLngBounds(
            southwest: const LatLng(2, -1),
            northeast: const LatLng(3, 1),
          ),
          isFalse);
    });

    test('pacman intersection', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(-1, -60),
            northeast: const LatLng(1, 60),
          ),
          LatLngBounds(
            southwest: const LatLng(-1, 30),
            northeast: const LatLng(1, -30),
          ),
          isTrue);
    });

    test('pacman disjoint', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(-1, -30),
            northeast: const LatLng(1, 30),
          ),
          LatLngBounds(
            southwest: const LatLng(-1, 60),
            northeast: const LatLng(1, -60),
          ),
          isFalse);
    });

    test('pacman half', () {
      testMutualIntersection(
          LatLngBounds(
            southwest: const LatLng(-1, -30),
            northeast: const LatLng(1, 60),
          ),
          LatLngBounds(
            southwest: const LatLng(-1, 30),
            northeast: const LatLng(1, -60),
          ),
          isTrue);
    });
  });
}
