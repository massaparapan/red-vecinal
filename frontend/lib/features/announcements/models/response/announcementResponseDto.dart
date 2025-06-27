class AnnouncementResponse {
  final int id;
  final String content;
  final DateTime createdAt;
  final String type;
  final CreatedBy createdBy;

  AnnouncementResponse({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.type,
    required this.createdBy,
  });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) {
    return AnnouncementResponse(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      type: json['type'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
    );
  }
}

class CreatedBy {
  final int id;
  final String username;
  final String phoneNumber;

  CreatedBy({
    required this.id,
    required this.username,
    required this.phoneNumber,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
