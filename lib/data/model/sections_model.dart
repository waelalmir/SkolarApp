class SectionsModel {
  int? id;
  int? gradeId;
  String? name;
  String? room;

  SectionsModel({this.id, this.gradeId, this.name, this.room});

  SectionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grade_id'] = this.gradeId;
    data['name'] = this.name;
    data['room'] = this.room;
    return data;
  }
}
