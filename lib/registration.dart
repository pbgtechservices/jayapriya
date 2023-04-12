import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shops/login.dart';
import 'package:get/get.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

final _getConnect = GetConnect();
var baseUrl = "https://s2m56.pythonanywhere.com";
String token = "";
bool signuperr = false;

class _RegistrationState extends State<Registration> {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientTypeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      signuperr = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign up',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          const SizedBox(
            height: 20,
          ),
          if (logerr) ...[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 20),
              child: const Text(
                "You couldn't signin please contact admin",
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
                  return 'Please enter Client name';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              controller: clientNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Client Name",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: clientTypeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Client Type",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Location';
                }
                return null;
              },
              controller: locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Location",
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
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
            child: TextFormField(
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Confirm password';
                }
                return null;
              },
              controller: confirmpassController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password",
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
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Text(
                  "Sign-In instead?",
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
                if (phoneController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    confirmpassController.text.isNotEmpty &&
                    clientNameController.text.isNotEmpty &&
                    clientTypeController.text.isNotEmpty &&
                    locationController.text.isNotEmpty) {
                  _sendPostRequest(
                      phoneController.text,
                      passwordController.text,
                      confirmpassController.text,
                      clientNameController.text,
                      clientTypeController.text,
                      locationController.text);
                } else {
                  print("No proper data found");
                }
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
    );
  }

  void _sendPostRequest(String email, String password, String password1,
      String cname, String ctype, String loc) async {
    print('${baseUrl}/api/v1/rest-auth/registration/');
    final response = await _getConnect.post(
      '${baseUrl}/api/v1/rest-auth/registration/',
      {
        'username': email,
        'password1': password,
        'password2': password1,
      },
    );
    if (kDebugMode) {
      setState(() {
        token = response.body['key'];
      });
      // print(response.body);
      if (response.isOk) {
        print(response.body['key']);
        final response1 = await _getConnect.post(
          '${baseUrl}/client/client-list/',
          {
            'Client_Name': cname,
            'Client_type': ctype,
            'Location': loc,
          },
          headers: <String, String>{"Authorization": 'Token $token'},
        );

        print(response1.body.toString());
        if (response1.isOk) {
          print("2nd ${response1.statusCode}");
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        }
      } else {
        setState(() {
          signuperr = true;
        });
        print(response.body);
      }
    }
  }
}
