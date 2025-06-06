class CommunityCreateDTO {
  final String name;
  final String description;
  final double lat;
  final double lon;

  CommunityCreateDTO({
    required this.name,
    required this.description,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'lat': lat,
      'lon': lon,
    };
  }
}
