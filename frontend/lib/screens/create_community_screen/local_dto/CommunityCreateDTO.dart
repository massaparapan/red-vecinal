class CommunityCreateDTO {
  final String name;
  final String description;
  final double lat;
  final double lon;
  final int membersCount;
  final String creationDate;

  CommunityCreateDTO({
    required this.name,
    required this.description,
    required this.lat,
    required this.lon,
    required this.membersCount,
    required this.creationDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'lat': lat,
      'lon': lon,
      'membersCount': membersCount,
      'creationDate': creationDate,
    };
  }
}
