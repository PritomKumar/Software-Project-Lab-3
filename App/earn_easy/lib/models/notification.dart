class NotificationMessage {
  final String title;
  final String body;
  final String uid;
  final String messageType;

  NotificationMessage({
    this.title,
    this.body,
    this.uid,
    this.messageType,
  });

  NotificationMessage.fromMap(Map<String, dynamic> data)
      : this.title = data["title"],
        this.body = data["body"],
        this.uid = data["uid"],
        this.messageType = data["messageType"];

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'body': this.body,
      'uid': this.uid,
      'messageType': this.messageType,
    };
  }
}
