import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shops/refferal.dart';
import 'package:shops/registration.dart';
import 'package:shops/status_check.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

final _connect = GetConnect();
List data = [];
bool empty = false;
void _sendGetRequest() async {
  print("here ${token}");
  print("${baseUrl}/reffarral/refferral-patient-list/");
  var headers = {
    'Content-Type': 'application/json',
    "Authorization": 'Token $token'
  };

  final response = await http.get(
    Uri.parse('${baseUrl}/reffarral/refferral-patient-list/'),
    headers: headers,
  );

  if (kDebugMode) {
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      if (data.isEmpty) {
        print("true");
        empty = true;
      }
      print(jsonDecode(response.body));
    } else {
      print("There is a error ${jsonDecode(response.body)}");
    }
  }
}

class _StatusState extends State<Status> {
  // ignore: prefer_typing_uninitialized_variables
  var id = "";
  // ignore: prefer_typing_uninitialized_variables
  var refpat = "";
  // ignore: prefer_typing_uninitialized_variables
  var status = "";
  // ignore: prefer_typing_uninitialized_variables
  var treatment = "";

  var uniqueval = 0;

  @override
  void initState() {
    super.initState();
    _sendGetRequest();
    // myFuture();
  }

  @override
  Widget build(BuildContext context) {
    // print("inside ${empty} & the length - ${data.length}");
    return Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              )
            ],
            // leading: const BackButton(
            //   color: Colors.black, // <-- SEE HERE
            // ),
            centerTitle: true,
            title: const Text("Jayapriya")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: const Text(
                  "Home Page",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              if (!empty) ...[
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextButton(
                        onPressed: () {
                          print("This is onclick - ${data[index]['id']}");
                          setState(() {
                            uniqueval = data[index]['id'];
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Status_check(
                                      index: uniqueval,
                                    )),
                          );
                        },
                        child: Text(
                            "${data[index]['id']} ${data[index]['Patient_Name']}"),
                      ),
                    );
                  },
                ),
              ] else ...[
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: const Text("No Data available"),
                      )
                    ],
                  ),
                )
              ],
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Refferal()),
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text("Add"),
              )
            ],
          ),
        ));
  }
}
