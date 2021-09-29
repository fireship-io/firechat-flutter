## Flutter Firechat

1. Create a new Flutter project via [Flutter Docs](https://flutter.dev/docs/get-started)
2. Create a new Firebase project
3. Enable Google Authentication and Firestore
4. Add a new Firebase Android app
5. Follow the Android SDK installation instructions
6. Download the google-services.json file and add it into the project's android/app folder
7. Install the packages for firebase, google sign in, and provider:

```sh
flutter pub add firebase_core firebase_auth google_sign_in cloud_firestore provider
```

8. Create new files in the 'lib' folder called 'auth_provider.dart', 'bottom_chat_bar.dart', 'home_screen.dart', 'landing_screen.dart', 'loading.dart', and 'styles.dart'
9. Add the code for 'auth_provider.dart', 'bottom_chat_bar.dart', 'home_screen.dart', 'landing_screen.dart', 'loading.dart', 'styles.dart' and main.dart
10. Auth logic and initialization lives in the 'auth_provider.dart' and 'main.dart' files
