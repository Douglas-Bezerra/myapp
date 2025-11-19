class User {
  String email;
  String password;

  User({
    required this.email, 
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) => User(email: json['email'], password: json['password']);

  get id => null;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}