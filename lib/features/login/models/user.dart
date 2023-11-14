class MyUser {
  String name, email, password, userId;

  MyUser({
    required this.name,
    required this.email,
    this.password = '',
    this.userId = '',
  });

  factory MyUser.fromJson(Map<String, dynamic> map) => MyUser(
        name: map['name'],
        email: map['email'],
        userId: map['userId'],
      );

  Map<String,dynamic> toMap()=>{
    'userId':userId,
    'email':email,
    'name':name
  };
}
