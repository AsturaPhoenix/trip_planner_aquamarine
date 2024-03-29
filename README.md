# BASK Trip Planner - Prototype: Aquamarine

This is a prototype cross-platform port of the BASK Trip Planner, for better offline use.

## Development

This project uses [Flutter](https://flutter.dev/). Install the dependencies as outlined at https://docs.flutter.dev/get-started/install, possibly stopping short of installing Flutter itself.

Flutter needs a fork to address a couple issues:
* [flutter/flutter#116212](https://github.com/flutter/flutter/issues/116212)
* <s>[flutter/flutter#82016](https://github.com/flutter/flutter/issues/82016)</s> (still open but no longer required)
* [flutter/flutter#119966](https://github.com/flutter/flutter/issues/119966)
* [flutter/flutter#102469](https://github.com/flutter/flutter/issues/102469)

Fixes are at `git@github.com:AsturaPhoenix/flutter.git`, branch: `rosswang`. To use this fork,
```
git clone git@github.com:AsturaPhoenix/flutter.git -b rosswang
```
Then proceed with the instructions at https://docs.flutter.dev/get-started/install after the analogous `git clone`. Note a shallow clone will not work ([flutter/flutter#18532](https://github.com/flutter/flutter/issues/18532)).

The project will probably build and run with a stock Flutter install, but there will be bugs, and integration tests won't work.

If `pub get` fails with "filename too long", you may need to set `git config --system core.longpaths true`, delete the cached package that failed, and try again.

The recommended IDE is [Visual Studio Code](https://code.visualstudio.com/).

### Windows WSL

On Windows, it is recommended to use Flutter from Windows even if using WSL for Git, as otherwise Android Emulator probably won't be able to run with hardware acceleration, which can make it unusably slow.

There _may_ be ways to make it work with Flutter on WSL if you're determined enough. Please document them here.

### Code generation

Mocks and serialization use code generation. If the code needs to be regenerated, within the appropriate project subdirectory,
```
dart run build_runner build
```

### CORS

For local web, you'll need to build in debug or profile mode to use a classic Trip Planner instance that supports CORS (i.e. the alpha server or a local instance).

### SFBOFS aggregation server

To run the aggregation server for the current model, under the `server` directory, run

```
dart bin/main.dart
```

This will start an HTTP server on port 1080. Files will be stored under `server/persistence`, requiring 800 KB for each hour of data. The local server is only used in web debug and profile builds. If a local server is not running, these builds will fall back to the alpha server.

## Testing

### Unit/widget tests

Unit/widget tests may be run from the IDE or the command line within the appropriate project subdirectory.

```
flutter test
```

or for Dart projects,

```
dart test
```

### Integration tests

To run the integration tests, under the `app` subdirectory,

```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/integration_test.dart
```

Native tests are run using the [`patrol_cli`](https://pub.dev/packages/patrol_cli). We're using an older version of `patrol_cli`; `patrol drive` was removed for the 1.0 release, which sacrificed native screenshots for ability to run on device farms.

Under the `app` subdirectory,

```
dart run patrol_cli:main drive -t integration_test/native_test.dart
```

We need to use `dart run`, which uses our `dev_dependencies`, rather than `dart pub global activate` to manage dependencies of `patrol_cli` without upper bounds that may no longer be compatible.

## Building

For web, a typical build is, under the `app` subdirectory,

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

**Flutter tools fail complaining of "v0.0.0-unknown"**

* Shallow checkouts of Flutter will not work ([flutter/flutter#18532](https://github.com/flutter/flutter/issues/18532)).
* Run `git fetch --unshallow` in your Flutter repo.

### Web

**Info panel doesn't show up**

* The build must be in debug or profile mode to use local endpoints or the CORS-permissive alpha server.

**Detail panel images don't show up**

* The local or alpha server classic Trip Planner may need its forwarding redirected to the latest prod Trip Planner.

**Things don't work on a mobile browser**

* Check whether there's a [`--web-renderer`](https://docs.flutter.dev/platform-integration/web/renderers) issue. By default, desktop web is rendered using the CanvasKit renderer but mobile web is rendered using the HTML renderer. This can lead to inconsistencies or things being broken on one or the other.
