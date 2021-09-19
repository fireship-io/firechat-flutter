// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/auth_provider.dart';
import 'package:firechat/home_screen.dart';
import 'package:firechat/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            // Something is broken
            return const Center(child: Text("Something went wrong!"));
          } else if (snapshot.hasData) {
            // Home (chat) screen
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
                        Icon(Icons.login, size: 30.0),
                        SizedBox(width: 10.0),
                        Text(
                          "GOOGLE SIGN IN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // Handle sign in
                    onPressed: () {
                      final provider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );
                      provider.googleLogin();
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