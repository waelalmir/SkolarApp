class StudentsModel {
  int? studentId;
  int? userId;
  String? studentCode;
  String? dob;
  int? gradeId;
  int? sectionId;
  int? parentId;
  String? enrollmentDate;
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

  StudentsModel({
    this.studentId,
    this.userId,
    this.studentCode,
    this.dob,
    this.gradeId,
    this.sectionId,
    this.parentId,
    this.enrollmentDate,
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

  StudentsModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    userId = json['user_id'];
    studentCode = json['student_code'];
    dob = json['dob'];
    gradeId = json['grade_id'];
    sectionId = json['section_id'];
    parentId = json['parent_id'];
    enrollmentDate = json['enrollment_date'];
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
    data['student_id'] = this.studentId;
    data['user_id'] = this.userId;
    data['student_code'] = this.studentCode;
    data['dob'] = this.dob;
    data['grade_id'] = this.gradeId;
    data['section_id'] = this.sectionId;
    data['parent_id'] = this.parentId;
    data['enrollment_date'] = this.enrollmentDate;
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
