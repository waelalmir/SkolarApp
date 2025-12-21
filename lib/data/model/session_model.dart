class SessionModel {
  int? id;
  int? gradeId;
  int? sectionId;
  int? subjectId;
  int? teacherId;
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  String? gradeName;
  String? subjectName;
  String? sectionName;
  String? teacherFullName;

  SessionModel({
    this.id,
    this.gradeId,
    this.sectionId,
    this.subjectId,
    this.teacherId,
    this.dayOfWeek,
    this.startTime,
    this.endTime,
    this.gradeName,
    this.subjectName,
    this.sectionName,
    this.teacherFullName,
  });

  SessionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    dayOfWeek = json['day_of_week'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    gradeName = json['grade_name'];
    subjectName = json['subject_name'];
    sectionName = json['section_name'];
    teacherFullName = json['teacher_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grade_id'] = this.gradeId;
    data['section_id'] = this.sectionId;
    data['subject_id'] = this.subjectId;
    data['teacher_id'] = this.teacherId;
    data['day_of_week'] = this.dayOfWeek;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['grade_name'] = this.gradeName;
    data['subject_name'] = this.subjectName;
    data['section_name'] = this.sectionName;
    data['teacher_full_name'] = this.teacherFullName;
    return data;
  }
}
