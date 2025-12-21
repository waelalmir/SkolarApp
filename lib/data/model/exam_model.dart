class ExamModel {
  int? examId;
  String? examDate;
  String? term;
  String? examType;
  String? gradeName;
  String? subjectName;

  ExamModel({
    this.examId,
    this.examDate,
    this.term,
    this.examType,
    this.gradeName,
    this.subjectName,
  });

  ExamModel.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    examDate = json['exam_date'];
    term = json['term'];
    examType = json['exam_type'];
    gradeName = json['grade_name'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_id'] = this.examId;
    data['exam_date'] = this.examDate;
    data['term'] = this.term;
    data['exam_type'] = this.examType;
    data['grade_name'] = this.gradeName;
    data['subject_name'] = this.subjectName;
    return data;
  }
}
