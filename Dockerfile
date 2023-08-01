# https://hub.docker.com/_/dart
FROM dart:stable AS build

# Copy files.
WORKDIR /app
COPY . .

# Resolve dependencies and compile.
WORKDIR /app/server
RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/main

# Build minimal serving image from AOT-compiled executable and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/server/bin/main /server/bin/

# Mount persistence.
VOLUME /server/persistence

# Start server.
EXPOSE 1080
WORKDIR /server
CMD [ "bin/main" ]