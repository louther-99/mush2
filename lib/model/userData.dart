import 'package:meta/meta.dart';

class UserField {
  static final String lastMessageTime = lastMessageTime;
}

class UserData{
  final String IDUser;
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String AvatarURL;
  final DateTime lastMessageTime;

  const UserData({
    required this.IDUser,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.AvatarURL,
    required this.lastMessageTime
  });

  UserData copyWith({
    String? IDUser,
    String? imagePath,
    String? name,
    String? email,
    String? about,
    String? AvatarURL,
    DateTime? lastMessageTime,

  }) => UserData( //Return an new user instance
    IDUser: IDUser ?? this.IDUser,
    imagePath: imagePath ?? this.imagePath,
    name: name ?? this.name,
    email: email ?? this.email,
    about: about ?? this.about,
    AvatarURL: AvatarURL ?? this.AvatarURL,
    lastMessageTime : lastMessageTime ?? this.lastMessageTime,

  );

  static UserData fromJson(Map<String, dynamic> json) => UserData(
      IDUser: json['IDUser'],
      imagePath: json['imagePath'],
      name: json['name'],
      email: json['email'],
      about: json['email'],
      AvatarURL: json['AvatarURL'],
      lastMessageTime : json['lastMessageTime']

  );

  Map<String, dynamic> toJson() => {
    'IDUser': IDUser,
    'imagePath': imagePath,
    'name': name,
    'email': email,
    'about': about,
    'AvatarURL': AvatarURL,
    'lastMessageTime' : lastMessageTime
  };




}
