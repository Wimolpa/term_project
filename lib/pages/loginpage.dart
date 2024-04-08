import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:term_project/helpers/api_caller.dart';
import 'package:term_project/helpers/my_text_fild.dart';
import 'package:term_project/helpers/storage.dart';
import 'package:term_project/pages/homepage.dart';

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
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('รีวิวเว่อ', style: TextStyle(fontSize: 40.0)),
            Text('LOGIN', style: TextStyle(fontSize: 15.0)),
            // Text('LOGIN', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 20.0),
            MyTextField(
              controller: _usernameController,
              hintText: 'Enter username',
            ),
            SizedBox(height: 20.0),
            MyTextField(
              controller: _passwordController,
              hintText: 'Enter password',
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

                if (json['error'] == 'Unauthorized') {
                  print(json['error']);
                } else {
                  print("THIS IS ELSE");
                  var token = json['token'];
                  var fullName = json['user']['fullName'];
                  var id = json['user']['id'];
                  var storage = Storage();
                  await storage.write(
                    Storage.keyId,
                    json['user']['id'].toString(),
                  );

                  debugPrint('ID: $id,Token: $token, Full Name: $fullName');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: Text('Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue[700])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
