class SubjectsModel {
  int? id;
  String? name;
  int? gradeId;

  SubjectsModel({this.id, this.name, this.gradeId});

  SubjectsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gradeId = json['grade_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['grade_id'] = this.gradeId;
    return data;
  }
}
