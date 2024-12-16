
class User {
  final int id;
  final String clientId;
  final String userName;
  final String email;
  final String role;
  final String orgType;
  final int org;
  final int owner;
  final String noderedUrl;

  User({
    required this.id,
    required this.clientId,
    required this.userName,
    required this.email,
    required this.role,
    required this.orgType,
    required this.org,
    required this.owner,
    required this.noderedUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      clientId: json['clientId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      orgType: json['orgType'] as String,
      org: json['org'] as int,
      owner: json['owner'] as int,
      noderedUrl: json['nodered_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'userName': userName,
      'email': email,
      'role': role,
      'orgType': orgType,
      'org': org,
      'owner': owner,
      'nodered_url': noderedUrl,
    };
  }
}
