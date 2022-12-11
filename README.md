# BASK Trip Planner - Prototype: Aquamarine

This is a prototype cross-platform port of the BASK Trip Planner, for better offline use.

## Development

### Forked dependencies

Flutter itself needs to be forked to address a couple issues:
* https://github.com/flutter/flutter/issues/116212
* https://github.com/flutter/flutter/issues/82016

Fixes are at `git@github.com:AsturaPhoenix/flutter.git`, branch: `rosswang`.

Additionally, the following git repos should exist as siblings to `trip_planner_aquamarine`:
* `git@github.com:AsturaPhoenix/joda_time.git`
* `git@github.com:AsturaPhoenix/flutter-plugins.git`, branch: `dev`
* `git@github.com:AsturaPhoenix/flutter_html.git`, branch: `rosswang`
* `git@github.com:AsturaPhoenix/motion_sensors.git`, branch: `rosswang`

### Configuration

In `.vscode`, create a `settings.json` file with a configuration value for `mapsApiKey`:

```json
{
  "mapsApiKey": "..."
}
```

This will be injected into Android and iOS builds. For web, you'll need to live without an API key for debug or edit the generated `index.html` after build for now.

### CORS

For local web, you'll need a local trip planner at `http://localhost/trip_planner/` with `Header set Access-Control-Allow-Origin *` to serve resources that would otherwise be CORS restricted.

## Building

For web, a typical build is

```
flutter build web --base-href "/trip_planner_aquamarine/"
```

Remember to add your Google Maps API key to `build/web/index.html`.