class User {
  int? id;
  String username;
  String email;
  String names;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.names,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['ID'],
    username: json['username'],
    email: json['email'],
    names: json['names'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'names': names,
  };
}