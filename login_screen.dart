import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'menu_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Your login form UI here

          ElevatedButton(
            onPressed: () {
              // Add logic to authenticate user
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            },
            child: Text('Login'),
          ),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()),
              );
            },
            child: Text('Create an account'),
          ),
        ],
      ),
    );
  }
}

