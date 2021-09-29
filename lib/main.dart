import 'package:firebase_core/firebase_core.dart';
import 'package:firechat/landing_screen.dart';
import 'package:firechat/styles.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Flutterfire
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // print(snapshot.error);
          return Center(
            child: Text('$snapshot.error'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }
        return const Text('loading...');
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firechat',
      debugShowCheckedModeBanner: false,
      theme: themeStyle,
      home: const LandingScreen(), // Main entry point for the app
    );
  }
}
