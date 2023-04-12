import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shops/home.dart';
import 'package:shops/notify_service.dart';
import 'package:shops/registration.dart';

class Refferal extends StatefulWidget {
  const Refferal({super.key});

  @override
  State<Refferal> createState() => _RefferalState();
}

class _RefferalState extends State<Refferal> {
  TextEditingController PatientNameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController ComplaintController = TextEditingController();
  TextEditingController InstructionsController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Gender"), value: "Gender"),
      DropdownMenuItem(child: Text("Male"), value: "Male"),
      DropdownMenuItem(child: Text("Female"), value: "Female"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];
    return menuItems;
  }

  String selectedValue = "Gender";

  late PlatformFile file;

  void pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(withData: true);

    if (kDebugMode) {
      if (result != null) {
        setState(() {
          file = result.files.single;
          // file = File("");
        });
        // print("getting the result - ${result!.files.single.path}");
        print("File in bytes ${file.path}");
      }
      // if (result != null) {
      //   setState(() {
      //     // file = File(result.files.single.path);
      //     file = File("");
      //   });
      // }
      else {
        print("No data selected");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          leading: const BackButton(
            color: Colors.black, // <-- SEE HERE
          ),
          centerTitle: true,
          title: const Text("Jayapriya")),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Refferal",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
          ),
          const SizedBox(
            height: 12,
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
              keyboardType: TextInputType.name,
              controller: PatientNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Patient Name",
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
                  return 'Please enter patient name';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              minLines: 1,
              maxLength: 3,
              controller: AgeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Age",
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
                  return 'Please enter Complaint';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              controller: ComplaintController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Complaint",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
              child: DropdownButtonFormField(
                value: selectedValue,
                items: dropdownItems,
                validator: (value) {
                  if (value == selectedValue) {
                    return "Please select your gender";
                  }
                  return null;
                },
                onChanged: (newvalue) => {
                  setState(() {
                    selectedValue = newvalue!;
                  })
                },
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: InstructionsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Instructions",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 2, 10, 5),
              child: ElevatedButton.icon(
                onPressed: () {
                  pickFile();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    elevation: 3,
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(30),
                    )),
                icon: const Icon(Icons.upload),
                label: const Text(
                  "Uploads",
                  style: TextStyle(fontSize: 25),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
            child: ElevatedButton(
              onPressed: () {
                _sendPostRequest(
                    PatientNameController.text,
                    AgeController.text,
                    ComplaintController.text,
                    InstructionsController.text,
                    selectedValue,
                    file.path);
              },
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: const Text("Show notification "),
              onPressed: () {
                NotificationService()
                    .showNotification(title: 'Sample title', body: 'It works');
              },
            ),
          )
        ],
      ),
    );
  }

  // Object? sendProfileImage(upload) async {
  //   var request = http.MultipartRequest(
  //       'post', Uri.parse("${baseUrl}/reffarral/refferral-patient-list/"));

  //   request.headers.addAll({
  //     'Content-Type':
  //         'multipart/form-data;boundary=----WebKitFormBoundaryyrV7KO0BoCBuDbTL',
  //     "Authorization": 'Token $token',
  //   });
  //   var data = http.MultipartFile.fromBytes('files.myimage', upload,
  //       filename: 'patient');

  //   request.files.add(data);
  //   var res = await request.send();
  //   print('profile image status code ${res.statusCode}');

  //   if (res.statusCode == 400) {
  //     print('profile image status code ${res.reasonPhrase}');
  //   }
  // }

  void _sendPostRequest(
    String patient,
    String age,
    String complaint,
    String gender,
    String instructions,
    upload,
  ) async {
    print("This is the token value - ${token}");

    var headers = {
      'Authorization': 'Token 2b98b5ae1d09d3109e688d46284aa67592404ce0',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}/reffarral/refferral-patient-list/'));
    request.fields.addAll({
      'Patient_Name': patient,
      'Age': age,
      'Complaint': complaint,
      'Gender': gender,
      'Instructions': instructions
    });
    request.files
        .add(await http.MultipartFile.fromPath('Instruction_File', upload));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("This is from here ${await response.stream.bytesToString()}");
    } else {
      print("This is from else - ${response.reasonPhrase}");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
