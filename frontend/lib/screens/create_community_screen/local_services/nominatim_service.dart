import 'dart:convert';
import 'package:http/http.dart' as http;

class NominatimService {
  static Future<Map<String, double>?> geocodeAddress(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$encodedAddress&format=json&limit=1',
    );

    final response = await http.get(url, headers: {
      'User-Agent': 'FlutterAppRedVecinal/1.0 (nanexz12@gmail.com)' 
    });

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        return {'lat': lat, 'lon': lon};
      }
    }

    return null;
  }
}
