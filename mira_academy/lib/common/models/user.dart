// ignore_for_file: non_constant_identifier_names

/*class UserProfile{
  String? name;
  int? age;
  String? job;
  UserProfile({this.name, this.age, this.job});
}

void main(){
  UserProfile profile = UserProfile();
}






*/













import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRequestEntity {
  int? type;
  String? name;
  String? description;
  String? email;
  String? phone;
  String? avatar;
  String? open_id;
  int? online;

  LoginRequestEntity({
    this.type,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.avatar,
    this.open_id,
    this.online,
  });

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "description": description,
    "email": email,
    "phone": phone,
    "avatar": avatar,
    "open_id": open_id,
    "online": online,
  };
}
//api post response msg
class UserLoginResponseEntity {
  int? code;
  String? msg;
  UserProfile? data;

  UserLoginResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: UserProfile.fromJson(json["data"]),
      );
}


// login result
class UserProfile {
  String? access_token;
  String? token;
  String? name;
  String? description;
  String? avatar;
  int? online;
  int? type;

  UserProfile({
    this.access_token,
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.type,
  });

  // Boş bir UserProfile oluşturmak için factory constructor
  factory UserProfile.empty() {
    return UserProfile(
      access_token: null,
      token: null,
      name: null,
      description: null,
      avatar: null,
      online: 0,
      type: 0,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    try {
      return UserProfile(
        access_token: json["access_token"]?.toString(),
        token: json["token"]?.toString(),
        name: json["name"]?.toString(),
        description: json["description"]?.toString(),
        avatar: json["avatar"]?.toString(),
        online: json["online"] is int ? json["online"] : 0,
        type: json["type"] is int ? json["type"] : 0,
      );
    } catch (e) {
      print("UserProfile parse error: $e");
      return UserProfile.empty();
    }
  }

  Map<String, dynamic> toJson() => {
    "access_token": access_token,
    "token": token,
    "name": name,
    "description": description,
    "avatar": avatar,
    "online": online,
    "type": type,
  };
}

class UserData {
  final String? token;
  final String? name;
  final String? avatar;
  final String? description;
  final int? online;

  UserData({
    this.token,
    this.name,
    this.avatar,
    this.description,
    this.online,
  });

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserData(
      token: data?['token'],
      name: data?['name'],
      avatar: data?['avatar'],
      description: data?['description'],
      online: data?['online'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (description != null) "description": description,
      if (online != null) "online": online,
    };
  }
}




