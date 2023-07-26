import 'dart:io';

import 'package:http/http.dart';

extension ClientExtensions on Client {
  // Convenience for setting up local overrides.
  Future<Uri?> test(Uri url) async {
    try {
      await send(Request('HEAD', url));
      return url;
    } on ClientException {
      return null;
    }
  }

  Future<Uri> resolveRedirects(
    Uri url, {
    int maxRedirects = 5,
  }) async {
    final redirects = <RedirectInfo>[];
    while (redirects.length <= maxRedirects) {
      final response =
          await send(Request('HEAD', url)..followRedirects = false);
      if (response.isRedirect) {
        url = Uri.parse(response.headers['location']!);
        redirects.add(
          _RedirectInfo(
            location: url,
            method: 'HEAD',
            statusCode: response.statusCode,
          ),
        );
      } else if (response.statusCode == HttpStatus.ok) {
        return url;
      } else {
        throw response;
      }
    }
    throw RedirectException('Too many redirects', redirects);
  }
}

class _RedirectInfo implements RedirectInfo {
  _RedirectInfo({
    required this.location,
    required this.method,
    required this.statusCode,
  });

  @override
  final Uri location;
  @override
  final String method;
  @override
  final int statusCode;
}
