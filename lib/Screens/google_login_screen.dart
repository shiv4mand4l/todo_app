import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:printing/printing.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  // firebase auth then google sign in
  String token = 'lodaing ...';
  bool isLoading = false;

  User? _user;
  String? _error = '';

  @override
  void initState() {
    getFCMToken();
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });

    GoogleSignIn.instance.initialize();
  }

  // Firebase User login
  Future<void> login() async {
    try {
      setState(() {
        isLoading = true;
      });
      // when user click in login button
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      // ignore: dead_code
      if (googleUser == null) {
        // cancel by user
      }

      // step 2
      final googleAuth = googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth!.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // print(e);
      _error = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Firebase User logout
  Future<void> logout() async {
    GoogleSignIn.instance.signOut();
  }

  // @override
  // void initState() {
  //   getFCMToken();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Login Screen'), centerTitle: true),
      body: Column(
        // spacing: 50,
        children: [
          isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    // google sign in
                    _user == null ? login() : logout();
                  },
                  child: Text('Google Login'),
                ),
          Text('User name: ${_user?.displayName ?? 'n/a'}'),
          Text('Email: ${_user?.email ?? 'n/a'} '),
          Text('Email: ${_user?.emailVerified ?? 'n/a'} '),
          // Text(_user?.phoneNumber ?? 'n/a'),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(_user?.photoURL ?? 'Nothimg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // child: Text('FCM Token is : "$token"'),
          ),
        ],
      ),
    );
  }

  // get FCM token
  Future<void> getFCMToken() async {
    // requestPermission to user
    await FirebaseMessaging.instance.requestPermission();

    // get FCM token from firebase messaging

    String? t = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = t ?? 'No Token Found 🥲';
    });

    print('Fcm Token is : "$token"');
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   if (kDebugMode) {
    //     print('Foreground: ${message.notification?.title}');
    //   }
    // });

    // RemoteMessage? initialMessage = await FirebaseMessaging.instance
    //     .getInitialMessage();
    // if (initialMessage != null) {
    //   print('From Terminated Stste');
    // }
  }
}
