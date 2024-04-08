import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:term_project/helpers/api_caller.dart';
import 'package:term_project/helpers/storage.dart';
import 'package:term_project/pages/homepage.dart';
import 'package:term_project/pages/homepage1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security, size: 80.0),
            Text('LOGIN', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Enter username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                print('Username: ${_usernameController.text}');
                print('Password: ${_passwordController.text}');
                var caller = ApiCaller();
                var data = await caller.post(
                  'login',
                  params: {
                    "username": _usernameController.text,
                    "password": _passwordController.text
                  },
                );
                debugPrint(data);

                var json = jsonDecode(data);
                var err = json['error'];
                if (err == 'Unauthorized') {
                  print('error: $err');
                } else {
                  var token = json['token'];
                  var fullName = json['user']['fullName'];
                  debugPrint('Token: $token, Full Name: $fullName');

                  // var storage = Storage();
                  // storage.write(Storage.keyToken, token);
                  // storage.write(Storage.keyFullName, fullName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage1();
                      },
                    ),
                  );
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
