class AttendanceModel {
  String? date;
  String? status;

  AttendanceModel({this.date, this.status});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
  }
}
