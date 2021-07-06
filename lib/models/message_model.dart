class MessageModel {
  String? messageText;
  String? dateTime;
  String? senderId;
  String? receiverId;


  MessageModel({
    required this.messageText,
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
  });

  MessageModel.fromFirebase(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    messageText = json['messageText'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
  }

  toMap() {
    return {
      'dateTime': dateTime,
      'messageText': messageText,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}
