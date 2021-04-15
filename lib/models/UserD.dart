import 'package:cloud_firestore/cloud_firestore.dart';

class UserD {
  UserD(
      {this.dapperID,
      this.username,
      this.profileImageUrl,
      this.twitterHandle,
      this.createdAt,
      this.flowAddress,
      this.favoriteTeamID});

  final String? dapperID;
  final String? username;
  final String? profileImageUrl;
  final String? twitterHandle;
  final DateTime? createdAt;
  final String? flowAddress;
  final String? favoriteTeamID;

  factory UserD.fromMap(Map<String, dynamic> json) => UserD(
      dapperID: json["dapperID"] == null ? null : json["dapperID"],
      username: json["username"] == null ? null : json["username"],
      profileImageUrl:
          json["profileImageUrl"] == null ? null : json["profileImageUrl"],
      twitterHandle:
          json["twitterHandle"] == null ? null : json["twitterHandle"],
      createdAt: json["createdAt"] == null
          ? null
          : json["createdAt"] is Timestamp
              ? DateTime.fromMillisecondsSinceEpoch(
                  json["createdAt"].millisecondsSinceEpoch)
              : DateTime.parse(json["createdAt"]),
      flowAddress: json["flowAddress"] == null ? null : json["flowAddress"],
      favoriteTeamID:
          json["favoriteTeamID"] == null ? null : json["favoriteTeamID"]);

  Map<String, dynamic> toMap() => {
        "dapperID": dapperID,
        "username": username,
        "profileImageUrl": profileImageUrl,
        "twitterHandle": twitterHandle,
        "createdAt": createdAt,
        "flowAddress": flowAddress,
        "favoriteTeamID": favoriteTeamID,
      };

  @override
  String toString() {
    return """
    UserD(
      dapperID: $dapperID,
      username: $username,
      profileImageUrl: $profileImageUrl,
      twitterHandle: $twitterHandle,
      createdAt: $createdAt,
      flowAddress: $flowAddress,
      favoriteTeamID: $favoriteTeamID,
      )';
    """;
  }
}
