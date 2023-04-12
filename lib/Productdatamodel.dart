class Productdatamodel {
  late String idNo;
  // String reffered;
  // String patientStatus;
  // String treatment;

  // Productdatamodel(
  //     {this.id, this.reffered, this.patientStatus, this.treatment});

  // Productdatamodel({required this.id});

  // Productdatamodel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   reffered = json['reffered'];
  //   patientStatus = json['PatientStatus'];
  //   treatment = json['Treatment'];
  // }

  // Productdatamodel.fromJson(Map<String, dynamic> json) {
  // id = json['id'];
  // reffered = json['reffered'];
  // patientStatus = json['PatientStatus'];
  // treatment = json['Treatment'];
  // }

  String get getName {
    return idNo;
  }

  Productdatamodel setName(item) => idNo = item;
}
