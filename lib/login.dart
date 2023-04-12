import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shops/home.dart';
import 'package:shops/registration.dart';
import 'package:shops/status.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final _getConnect = GetConnect();

String loginerr = "";
bool logerr = false;

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      logerr = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("checking ${logerr}");
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Jayapriya"))),
      body: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            if (logerr) ...[
              Container(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 20),
                child: const Text(
                  "Please enter valid phone number and password",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Phone Number",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )),
            ),
            const SizedBox(
              height: 0,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: ElevatedButton(
                onPressed: () {
                  print("pressed");
                  _sendPostRequest(
                      phoneController.text, passwordController.text);

                  // if (passwordController.text == confirmpassController.text) {
                  //   print("password matched");
                  // } else {
                  //   print("didn't match");
                  // }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _sendPostRequest(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.post(
        Uri.parse('https://s2m56.pythonanywhere.com/api/v1/rest-auth/login/'),
        headers: headers,
        body: json.encode({"username": email, "password": password}));

    if (kDebugMode) {
      if (response.statusCode == 200) {
        var sol = jsonDecode(response.body);
        print("getting info ${sol['key']}");

        setState(() {
          token = sol['key'];
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Status()),
        );
      } else {
        setState(() {
          loginerr = "Please enter valid phone number and password";
          logerr = true;
        });
        print(jsonDecode(response.body));
      }
    }
  }
}
