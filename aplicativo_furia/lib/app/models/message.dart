class Message {
  final String? id;
  final String? userId;
  final String? content;
  final String? matchId;
  final DateTime? timestamp;

  Message({
    this.id,
    this.userId,
    this.content,
    this.matchId,
    this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'matchId': matchId,
      'timestamp': timestamp?.toIso8601String(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      userId: json['userId'],
      content: json['content'],
      matchId: json['matchId'],
      timestamp:
          json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
    );
  }
}
