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
git clone git@github.com:AsturaPhoenix/flutter.git -b rosswang --depth 1
```
(optionally omitting `--depth 1` if you anticipate working on the Flutter fork). Then proceed with the instructions at https://docs.flutter.dev/get-started/install after the analogous `git clone`.

The project will probably build and run with a stock Flutter install, but there will be bugs, and integration tests won't work.

If `pub get` fails with "filename too long", you may need to set `git config --system core.longpaths true`, delete the cached package that failed, and try again.

The recommended IDE is [Visual Studio Code](https://code.visualstudio.com/).

### Windows WSL

On Windows, it is recommended to use Flutter from Windows even if using WSL for Git, as otherwise Android Emulator probably won't be able to run with hardware acceleration, which can make it unusably slow.

There _may_ be ways to make it work with Flutter on WSL if you're determined enough. Please document them here.

### Code generation

Mocks and serialization use code generation. If the code needs to be regenerated,
```
dart run build_runner build
```

### CORS

For local web, you'll need a local trip planner at `http://localhost/trip_planner/` with `Header set Access-Control-Allow-Origin *` to serve resources that would otherwise be CORS restricted.

### SFBOFS aggregation server

To run the aggregation server for the current model, under the `server` directory, run

```
dart bin/main.dart
```

This will start an HTTP server on port 1080. Files will be stored under `server/persistence`, requiring 800 KB for each hour of data. The local server is used for web debug and profile builds.

## Testing

### Unit/widget tests

Unit/widget tests may be run from the IDE or the command line.

```
flutter test
```

### Integration tests

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

## Building

For web, a typical build is

```
flutter build web --base-href "/trip_planner_aquamarine/" --web-renderer canvaskit
```

CanvasKit is required as "`combinePaths` is not implemented in HTML renderer."

CI pushes a release build of the master branch to the alpha server at http://34.83.198.158/trip_planner_aquamarine automatically.

## Troubleshooting

**`pub get` fails with "filename too long"**

* You may need to set `git config --system core.longpaths true`, delete the cached package that failed, and try again.

**Analysis failures in CI but not locally**

* Try running `flutter pub upgrade` to pull the latest compatible versions of dependencies.

### Web

**Info panel does not show up**

* A local instance of the classic Trip Planner needs to be running at http://localhost/trip_planner.
* The build must be debug or profile to use the localhost endpoint.

**Things don't work on a mobile browser**

* Check whether there's a [`--web-renderer`](https://docs.flutter.dev/platform-integration/web/renderers) issue. By default, desktop web is rendered using the CanvasKit renderer but mobile web is rendered using the HTML renderer. This can lead to inconsistencies or things being broken on one or the other.
