import 'package:google_sign_in/google_sign_in.dart';
import 'package:topshot_scan/models/UserD.dart';

class AppUser {
  AppUser({this.name, this.email, this.account});

  final String? name;
  final String? email;
  final UserD? account;

  // factory AppUser.fromGMap(GoogleSignInAccount g) => AppUser(
  //       name: g.displayName == null ? null : g.displayName,
  //       email: g.email == null ? null : g.email,
  //       uid: g.uid == null ? null : g.uid,
  //       photo: g.photoUrl == null ? null : g.photoUrl,
  //     );

  factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
      name: json["name"] == null ? null : json["name"],
      email: json["email"] == null ? null : json["email"],
      account: json["account"] == null ? null : UserD.fromMap(json["account"]));

  Map<String, dynamic> toMap() =>
      {"name": name, "email": email, "account": account};

  @override
  String toString() {
    return """
    AppUser(
      name: $name,
      email: $email,
      account: $account
      )';
    """;
  }
}
