class UsersModel {
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

  UsersModel({
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

  UsersModel.fromJson(Map<String, dynamic> json) {
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
