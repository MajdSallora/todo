import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/constant/enum.dart';
import '../../../../common/constant/keys.dart';
import '../../../../injection/injection.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final Gender gender;
  final String image;
  final String token;

  User({
    required this.id,
    required this.image,
    required this.email,
    required this.token,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        image: json["image"],
        email: json["email"],
        token: json["token"],
        gender: Gender.getGender(json["gender"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"]);
  }

  String? _replaceFarsiNumber(String? s) {
    if (s == null) {
      return null;
    }
    var sb = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
        case '\u06f0':
          sb.write('0');
          break;
        case '\u06f1':
          sb.write('1');
          break;
        case '\u06f2':
          sb.write('2');
          break;
        case '\u06f3':
          sb.write('3');
          break;
        case '\u06f4':
          sb.write('4');
          break;
        case '\u06f5':
          sb.write('5');
          break;
        case '\u06f6':
          sb.write('6');
          break;
        case '\u06f7':
          sb.write('7');
          break;
        case '\u06f8':
          sb.write('8');
          break;
        case '\u06f9':
          sb.write('9');
          break;
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "email": email,
      "token": token,
      "gender": gender.name,
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
    };
  }

  static User? get() {
    try {
      final String? user = getIt<SharedPreferences>().getString(kUser);
      if (user != null) {
        return User.fromJson(jsonDecode(user));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static String getImage() {
    return get()?.image ?? "";
  }

  static String getName() {
    final user = get();
    if(user != null){
      return "${get()!.firstName} ${get()!.lastName}";
    }else{

    }
    return "";
  }

  static String? getToken() {
    return getIt<SharedPreferences>().getString(kToken);
  }

}
