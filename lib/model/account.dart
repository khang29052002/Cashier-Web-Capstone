class Account{
  final String accessToken;
  final String emailVerify;
  final String fogotToken;
  final String id;
  final String email;
  final String password;
  final String crDate;
  final String upsDate;
  final String status;
  final String userId;
  final String roleId;
      Account({
        required this.accessToken,
        required this.emailVerify,
        required this.fogotToken,
        required this.id,
        required this.email,
        required this.password,
        required this.crDate,
        required this.upsDate,
        required this.status,
        required this.userId,
        required this.roleId,
      });

      
      @override
  String toString() {
    return super.toString();
  }
    factory Account.fromJson(dynamic json) => Account(
      accessToken: json['accessToken'],
      emailVerify: json['emailVerify'],
      fogotToken: json['forgotToken'],
      id: json["id"],
      email: json["Email"],
      password: json['Password'],
      crDate: json['crDate'],
      upsDate: json['upsDate'],
      status: json['status'],
      roleId: json['roleId'],
      userId: json['userId']
      );

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken.toString(),
      "forgotToken": fogotToken.toString(),
      "emailVerify": emailVerify.toString(),
      "id": id.toString(),
      "email": email,
      "password": password,
      "crDate": crDate,
      "upsDate": upsDate,
      "status": status,
      "roleId": roleId.toString(),
      "userId": userId.toString(),
    };
  }
}
   