class User {
  final String usermail;
  final String password;

  User({required this.usermail, required this.password});

 
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      usermail: json['usermail'],
      password: json['password'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'username': usermail,
      'password': password,
    };
  }
}
