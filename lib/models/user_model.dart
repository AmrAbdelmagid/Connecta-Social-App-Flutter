class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? cover;
  String? bio;
  bool isEmailVerified = false;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    this.cover,
    this.image,
    this.bio,
    required this.isEmailVerified,
  });

  UserModel.fromFirebase(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

   toMap (){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uid' : uid,
      'cover' : cover,
      'image' : image,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }

}
