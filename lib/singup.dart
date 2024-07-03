import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_transport/database_helper';

import 'package:public_transport/sign.dart';
// Assuming SignupPage is defined in signup.dart
import 'package:public_transport/transport.dart'; // Assuming TransportHomePage is defined in transport.dart


class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  static const String _title = 'Public Transport Directory';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding:  EdgeInsets.all(10),
            child:  Text(
              'Public Transport Directory',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),  SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding:  EdgeInsets.all(10),
            color:  Color.fromARGB(255, 95, 144, 199),
            child:  Text(
              'Sign in',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Form(
            key: _formKey, // Assign the form key
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email), // Icon for email
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                 SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon:  Icon(Icons.lock), // Icon for password
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // Add more validation criteria for password if needed
                    return null;
                  },
                ),
              ],
            ),
          ),
            SizedBox(height: 10),
          Center(
            child: Container(
              height: 50,
              width: 200,
              padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String email = emailController.text;
                    String password = passwordController.text;

                    try {
                      // Replace with your actual user authentication logic
                      Map<String, dynamic>? user = await DatabaseHelper.instance.getUser(email, password);

                      if (user != null) {
                        Get.to(TransportHomePage());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => TransportHomePage()),
                        // );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Invalid email or password')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Error logging in')),
                      );
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('Login'),
                  SizedBox(width: 8),

                  ],
                ),
              ),
            ),
          ),
           SizedBox(height: 30),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 Text('Does not have an account?'),
                TextButton(
                  onPressed: () {
                    Get.to(SignupPage());
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignupPage()),
                    // );
                    // Navigate to sign-up screen
                  },
                  child:  Text('Sign up'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
