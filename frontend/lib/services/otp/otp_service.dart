import 'package:frontend/common/dto/response.dart';
import 'package:frontend/common/network/api_client.dart';

class OtpService {
  final ApiClient _client = ApiClient();
  final String baseUrl = "/otp";

  Future<ResponseDTO> sendOtp(String phoneNumber) async {
    if (phoneNumber == "") {
      return ResponseDTO(success: false, message: 'Por favor completar los campos');
    }

    final result = await _client.post(
      '$baseUrl/send',
      queryParams: {'phoneNumber': phoneNumber},
    );
    
    return result;
  }

  Future<ResponseDTO> verifyOtp(String phoneNumber, String code) async {
    final result = await _client.post(
      '$baseUrl/verify',
      body: {
        'phoneNumber': phoneNumber,
        'code': code,
      },
    );
  
    return result;
  }
}
