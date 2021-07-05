class PostModel {
  String? name;
  String? uid;
  String? image;
  String? postImage;
  String? text;
  String? dateTime;

  PostModel({
    required this.name,
    required this.uid,
    required this.image,
    required this.text,
    required this.dateTime,
    this.postImage,
  });

  PostModel.fromFirebase(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
