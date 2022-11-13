# BASK Trip Planner - Prototype: Aquamarine

This is a prototype cross-platform port of the BASK Trip Planner, for better offline use.

## Development

For local web, you'll need a local trip planner at `http://localhost/trip_planner/` with `Header set Access-Control-Allow-Origin *` to serve resources that would otherwise be CORS restricted.

The `google_maps_flutter_web` package sets `gestureHandling = "auto"`, so gesture handling will appear to be in cooperative mode (e.g. ctrl + scroll to zoom) whenever the Chrome dev tools window is open or after the Dart Debug Extension is closed.

### https://github.com/flutter/flutter/issues/103803

This app uses `Canvas.drawImage`, so it's broken on web under Flutter 3.3. Furthermore, `Picture.toImage` appears to leak WebGL contexts in 3.4, so you may need to switch to the master channel. A known good hash is `c76035429c3695a2e4920017be754beab59c720c`.

```
flutter channel master
flutter upgrade
```