import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter/services.dart' as rootBundle;
import 'package:shops/Productdatamodel.dart';
import 'package:http/http.dart' as http;
import 'package:shops/registration.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';

class Status_check extends StatefulWidget {
  final int index;
  Status_check({Key? key, required this.index}) : super(key: key);
  @override
  State<Status_check> createState() => _Status_checkState();
}

final _connect = GetConnect();
late Map<String, dynamic> val;

class _Status_checkState extends State<Status_check> {
  _sendGetRequest() async {
    // print("This is status_check - ${widget.index}");
    // print(
    //     " The URL - ${baseUrl}/reffarral/refferral-patient-details/${widget.index} ");

    final response = await _connect.get(
      '${baseUrl}/reffarral/refferral-patient-details/${widget.index}',
      headers: {"Authorization": 'Token $token'},
    );

    if (kDebugMode) {
      if (response.isOk) {
        // print("This is response - ${response.body}");
        val = await response.body;
      } else {
        print("There is a error ${response.statusCode} - ${response.body}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _sendGetRequest();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Jayapriya"),
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
        ),
        body:
            // FutureBuilder(
            //     future: ReadJsonData(),
            //     builder: (context, data) {
            //       if (data.hasError) {
            //         return Center(child: Text("${data.error}"));
            //       } else if (data.hasData) {
            //         var items = data.data as List<Productdatamodel>;
            //         return
            ListView.builder(
                // itemCount: items.isEmpty ? 0 : items.length,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Infividual Patient Info",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Refered Patient",
                          ),
                          initialValue: val['Patient_Name'],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Patient Status",
                          ),
                          initialValue: val['Visited'].toString(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Treatment Given",
                          ),
                          initialValue: val['Diagnosis'],
                          minLines: 1,
                          maxLines: 50,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        if (val["Instruction_File"] != null) ...[
                          Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.attach_file),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.amber,
                                  elevation: 20, // Elevation
                                  shadowColor: Colors.amber,
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 16, 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ) // Shadow Color
                                  ),
                              onPressed: _launchURL,
                              label: const Text(
                                'View Instruction_File',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(
                          height: 50,
                        ),
                        if (val["Diagnosis_Report"] != null) ...[
                          Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.attach_file),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.amber,
                                  elevation: 20, // Elevation
                                  shadowColor: Colors.amber,
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 16, 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ) // Shadow Color
                                  ),
                              onPressed: _launchURL,
                              label: const Text(
                                'View Diagnosis_Report',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  );
                })
        // } else {
        // show circular progress while data is getting fetched from json file
        // return const Center(
        // child: CircularProgressIndicator(),
        // );
        // }
        // }),
        );
  }

  Future<List<Productdatamodel>> ReadJsonData() async {
    // final jsondata = await rootBundle.rootBundle.loadString('{"id":"1"}');

    // final list = json.decode(jsondata) as List<Map<String, dynamic>>;
    List temp = [
      {'id': '2'}
    ];
    List<Productdatamodel> model = [];

    for (var item in model) {
      model.add(Productdatamodel().setName(item));
    }

    return model;
  }

  _launchURL() async {
    Uri _url = Uri.parse('https://www.google.com');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }
}
