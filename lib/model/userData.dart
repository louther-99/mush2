// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class UserField {
  static final String lastMessageTime = lastMessageTime;
}

class UserData{
  final String IDUser;
  final String profilePath;
  final String name;
  final String email;
  final String about;
  final String coverPath;
  final String lastMessageTime;

  const UserData({
    required this.IDUser,
    required this.profilePath,
    required this.name,
    required this.email,
    required this.about,
    required this.coverPath,
    required this.lastMessageTime
  });

  factory UserData.fromDocument(DocumentSnapshot doc){
    return UserData(
        IDUser: doc['IDUser'],
        profilePath: doc['profilePath'],
        name: doc['name'],
        email: doc['email'],
        about: doc['about'],
        coverPath: doc['coverPath'],
        lastMessageTime: doc['lastMessageTime']
    );
  }

  UserData copyWith({
    String? IDUser,
    String? profilePath,
    String? name,
    String? email,
    String? about,
    String? coverPath,
    String? lastMessageTime,

  }) => UserData( //Return an new user instance
    IDUser: IDUser ?? this.IDUser,
    profilePath: profilePath ?? this.profilePath,
    name: name ?? this.name,
    email: email ?? this.email,
    about: about ?? this.about,
    coverPath: coverPath ?? this.coverPath,
    lastMessageTime : lastMessageTime ?? this.lastMessageTime,

  );

  static UserData fromJson(Map<String, dynamic> json) => UserData( //String = key, dynamic = value. Converting json back to user Object
      IDUser: json['IDUser'],
      profilePath: json['profilePath'],
      name: json['name'],
      email: json['email'],
      about: json['email'],
      coverPath: json['coverPath'],
      lastMessageTime : json['lastMessageTime']

  );

  Map<String, dynamic> toJson() => { //To convert UserData object to JSON
    'IDUser': IDUser,
    'imagePath': profilePath,
    'name': name,
    'email': email,
    'about': about,
    'AvatarURL': coverPath,
    'lastMessageTime' : lastMessageTime
  };




}
