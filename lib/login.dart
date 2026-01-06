import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/myHomePage.dart';
import 'auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello World!')),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user;

  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  Future<void> click() async {
    final User? result = await signInWithGoogle();

    if (result == null) return;

    setState(() {
      user = result;
    });

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(result.displayName ?? ''),
      ),
    );
  }

  Widget googleLoginButton() {
    return OutlinedButton(
      onPressed: click,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        side: const BorderSide(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Image(image: AssetImage('assets/google_logo.png'), height: 35),
            SizedBox(width: 10),
            Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: googleLoginButton());
  }
}
