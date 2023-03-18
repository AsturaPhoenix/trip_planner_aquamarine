# BASK Trip Planner - Prototype: Aquamarine

This is a prototype cross-platform port of the BASK Trip Planner, for better offline use.

## Development

This project uses [Flutter](https://flutter.dev/). Install the dependencies as outlined at https://docs.flutter.dev/get-started/install, possibly stopping short of installing Flutter itself.

Flutter needs a fork to address a couple issues:
* https://github.com/flutter/flutter/issues/116212
* https://github.com/flutter/flutter/issues/82016
* https://github.com/flutter/flutter/issues/119966
* https://github.com/flutter/flutter/issues/102469

Fixes are at `git@github.com:AsturaPhoenix/flutter.git`, branch: `rosswang`. To use this fork,
```
git clone git@github.com:AsturaPhoenix/flutter.git -b rosswang --depth 1`
```
(optionally omitting `--depth 1` if you anticipate working on the Flutter fork). Then proceed with the instructions at https://docs.flutter.dev/get-started/install after the analogous `git clone`.

The project will probably build and run with a stock Flutter install, but there will be bugs, and integration tests won't work.

If `pub get` fails with "filename too long", you may need to set `git config --system core.longpaths true`, delete the cached package that failed, and try again.

The recommended IDE is [Visual Studio Code](https://code.visualstudio.com/).

### Windows WSL

On Windows, it is recommended to use Flutter from Windows even if using WSL for Git, as otherwise Android Emulator probably won't be able to run with hardware acceleration, which can make it unusably slow.

There _may_ be ways to make it work with Flutter on WSL if you're determined enough. Please document them here.

### Configuration

In `.vscode`, create a `settings.json` file with a configuration value for `mapsApiKey`:

```json
{
  "mapsApiKey": "..."
}
```

This will be injected into Android and iOS builds. For web, you'll need to live without an API key for debug or edit the generated `index.html` after build for now. For integration tests, you'll need to set a MAPS_API_KEY environment variable.

### Code generation

Mocks and serialization use code generation. If the code needs to be regenerated,
```
dart run build_runner build
```

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

To run the integration tests,

```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/integration_test.dart
```

Native tests are run using the [`patrol_cli`](https://pub.dev/packages/patrol_cli). We're using an older version of `patrol_cli`; `patrol drive` was removed for the 1.0 release, which sacrificed native screenshots for ability to run on device farms.

```
dart pub global activate patrol_cli 0.9.3
```

```
patrol drive -t integration_test/native_test.dart
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

CI pushes a release build of the master branch to the alpha server at http://35.233.215.192/trip_planner_aquamarine automatically.

## Troubleshooting

**`pub get` fails with "filename too long"**

* You may need to set `git config --system core.longpaths true`, delete the cached package that failed, and try again.

### Web

**Info panel does not show up**

* A local instance of the classic Trip Planner needs to be running at http://localhost/trip_planner.
* The build must be debug or profile to use the localhost endpoint.
