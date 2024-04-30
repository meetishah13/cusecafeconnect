class UserModel {
  final int? userID;
  final String? userEmail;
  final String? fName;
  final String? lName;
  final String? password;
  final String? phoneNo;
  final int? roleID;
  final int? cafeID;
  final String? photoPath;

  UserModel({
    this.userID,
    this.userEmail,
    this.fName,
    this.lName,
    this.password,
    this.phoneNo,
    this.roleID,
    this.cafeID,
    this.photoPath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      userEmail: json['userEmail'],
      fName: json['fName'],
      lName: json['lName'],
      password: json['password'],
      phoneNo: json['phoneNo'],
      roleID: json['roleID'],
      cafeID: json['cafeID'],
      photoPath: json['photoPath'],
    );
  }
}