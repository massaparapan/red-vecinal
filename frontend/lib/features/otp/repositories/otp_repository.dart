import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/otp/models/request/otp_verify_request.dart';
import 'package:frontend/features/otp/services/otp_service.dart';

class OtpRepository {
  final _storage = FlutterSecureStorage();
  final OtpService _otpService;
  OtpRepository() : _otpService = OtpService.withDefaults();

  Future<void> sendOtp({required String phoneNumber}) async {
    if (phoneNumber.isEmpty) {
      throw ("Por favor completar los datos");
    }

    try {
      await _otpService.sendOtp(phoneNumber);
    } on DioException catch (e) {
      throw (e.message ?? "Error inesperado.");
    }
  }

  Future<bool> verifyOtp({required phoneNumber, required String code}) async {
    try {
      final result = await _otpService.verifyOtp(
        OtpVerifyRequest(phoneNumber: phoneNumber, code: code),
      );
      if (!result.valid) {
        throw ("Codigo incorrecto");
      } 
      await _storage.write(key: "reset-token", value: result.token);
      return result.valid;
    } on DioException catch (e) {
      throw (e.message ?? "Error inesperado.");
    }
  }
}
