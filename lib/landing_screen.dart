import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/auth_provider.dart';
import 'package:firechat/home_screen.dart';
import 'package:firechat/loading.dart';
import 'package:firechat/styles.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong!"),
            );
          } else if (snapshot.hasData) {
            // Home (chats) screen
            return const HomeScreen();
          } else {
            // Login component
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: 225,
                  height: 50,
                  child: ElevatedButton(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.login,
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "GOOGLE SIGN IN",
                          textAlign: TextAlign.center,
                          style: googleText,
                        ),
                      ],
                    ),
                    onPressed: () {
                      // Handle sign in

                      AuthProvider().googleLogin();
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
