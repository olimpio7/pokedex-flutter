import 'connection_native.dart' if (dart.library.js_interop) 'connection_web.dart' as connection;

Future openDatabaseConnection() => connection.openDatabaseConnection();
