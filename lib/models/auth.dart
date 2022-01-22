class Auth {
  int id;
  String first_name;
  String last_name;
  String username;
  int id_university;
  String email;
  String account_type;
  String profile_pic;
  String password;
  String address;
  String phone;
  int faculty_id;

  Auth({
    this.id,
    this.password,
    this.email,
    this.username,
    this.address,
    this.phone,
    this.account_type,
    this.faculty_id,
    this.first_name,
    this.id_university,
    this.last_name,
    this.profile_pic,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        id_university: json["id_university"],
        email: json["email"],
        account_type: json["account_type"],
        profile_pic: json["profile_pic"],
        password: json["password"],
        faculty_id: json["faculty_id"],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'first_name': first_name,
        'last_name': last_name,
        'id_university': id_university,
        'email': email,
        'account_type': account_type,
        'profile_pic': profile_pic,
        'password': password,
        'address': address,
        'phone': phone,
        'faculty_id': faculty_id,
      };
}

// class Auths {
//   final List<dynamic> authList;

//   Auths({this.authList});

//   factory Auths.fromjson(Map<String, dynamic> jsonData) {
//     return Auths(
//       authList: jsonData['books'],
//     );
//   }
// }
