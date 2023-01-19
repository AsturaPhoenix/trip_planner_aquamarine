# BASK Trip Planner - Prototype: Aquamarine

This is a prototype cross-platform port of the BASK Trip Planner, for better offline use.

## Development

If `pub get` fails with "filename too long", you may need to set `git config --system core.longpaths true`, delete the cached package that failed, and try again.

### Forked dependencies

Flutter itself needs to be forked to address a couple issues:
* https://github.com/flutter/flutter/issues/116212
* https://github.com/flutter/flutter/issues/82016

Fixes are at `git@github.com:AsturaPhoenix/flutter.git`, branch: `rosswang`.

Other forks are tracked in `pubspec.yaml`.

### Configuration

In `.vscode`, create a `settings.json` file with a configuration value for `mapsApiKey`:

```json
{
  "mapsApiKey": "..."
}
```

This will be injected into Android and iOS builds. For web, you'll need to live without an API key for debug or edit the generated `index.html` after build for now. For integration tests, you'll need to set a MAPS_API_KEY environment variable.

### CORS

For local web, you'll need a local trip planner at `http://localhost/trip_planner/` with `Header set Access-Control-Allow-Origin *` to serve resources that would otherwise be CORS restricted.

## Testing

### Unit/widget tests

Unit/widget tests may be run from the IDE or the command line.

```
flutter test
```

### Integration tests

To test with Google Maps, a `MAPS_API_KEY` environment variable must be set.

*Windows PowerShell*

```
$env:MAPS_API_KEY = "..."
```

To run the tests,

```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/integration_test.dart
```

### Performance tests

https://docs.flutter.dev/testing/integration-tests#running-in-a-browser

```
flutter drive -d chrome --driver test_driver/integration_test.dart --target integration_test/performance_test.dart --profile
```

## Building

For web, a typical build is

```
flutter build web --base-href "/trip_planner_aquamarine/"
```

Remember to add your Google Maps API key to `build/web/index.html`.