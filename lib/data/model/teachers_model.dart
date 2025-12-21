class TeachersModel {
  int? teacherId;
  int? userId;
  int? subjectId;
  int? gradeId;
  int? sectionId;
  int? id;
  String? email;
  String? phone;
  String? passwordHash;
  String? firstName;
  String? lastName;
  String? avatar;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? role;

  TeachersModel({
    this.teacherId,
    this.userId,
    this.subjectId,
    this.gradeId,
    this.sectionId,
    this.id,
    this.email,
    this.phone,
    this.passwordHash,
    this.firstName,
    this.lastName,
    this.avatar,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  TeachersModel.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    userId = json['user_id'];
    subjectId = json['subject_id'];
    gradeId = json['grade_id'];
    sectionId = json['section_id'];
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    passwordHash = json['password_hash'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacher_id'] = this.teacherId;
    data['user_id'] = this.userId;
    data['subject_id'] = this.subjectId;
    data['grade_id'] = this.gradeId;
    data['section_id'] = this.sectionId;
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password_hash'] = this.passwordHash;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    return data;
  }
}
