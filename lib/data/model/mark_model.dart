class MarkModel {
  int? gradeMarkId;
  int? studentMark;
  int? studentId;
  String? studentCode;
  int? studentUserId;
  int? examId;
  String? examDate;
  String? examType;
  String? term;
  int? subjectId;
  String? subjectName;
  int? gradeId;
  String? gradeName;

  MarkModel({
    this.gradeMarkId,
    this.studentMark,
    this.studentId,
    this.studentCode,
    this.studentUserId,
    this.examId,
    this.examDate,
    this.examType,
    this.term,
    this.subjectId,
    this.subjectName,
    this.gradeId,
    this.gradeName,
  });

  MarkModel.fromJson(Map<String, dynamic> json) {
    gradeMarkId = json['grade_mark_id'];
    studentMark = json['student_mark'];
    studentId = json['student_id'];
    studentCode = json['student_code'];
    studentUserId = json['student_user_id'];
    examId = json['exam_id'];
    examDate = json['exam_date'];
    examType = json['exam_type'];
    term = json['term'];
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    gradeId = json['grade_id'];
    gradeName = json['grade_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade_mark_id'] = this.gradeMarkId;
    data['student_mark'] = this.studentMark;
    data['student_id'] = this.studentId;
    data['student_code'] = this.studentCode;
    data['student_user_id'] = this.studentUserId;
    data['exam_id'] = this.examId;
    data['exam_date'] = this.examDate;
    data['exam_type'] = this.examType;
    data['term'] = this.term;
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    data['grade_id'] = this.gradeId;
    data['grade_name'] = this.gradeName;
    return data;
  }
}
