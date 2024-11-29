class Message {
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final String role; 

  Message({
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.role = 'user', 
  });

  Map<String, dynamic> toJson() {
    return {
      'role': isUser ? 'user' : 'model',
      'parts': [{'text': content}],
    };
  }
}