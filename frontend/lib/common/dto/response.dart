class ResponseDTO {
  final bool success;
  final String? message;
  final Object? data;

  ResponseDTO({
    required this.success,
    required this.message,
    this.data,
  });

  factory ResponseDTO.fromJson(
    Map<String, dynamic> json, {
    Object? Function(Map<String, dynamic>)? fromJsonData,
  }) {
    return ResponseDTO(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null && fromJsonData != null
          ? fromJsonData(json['data'])
          : json['data'],
    );
  }

  Map<String, dynamic> toJson({
    Map<String, dynamic> Function(Object)? toJsonData,
  }) {
    return {
      'success': success,
      'message': message,
      'data': data != null && toJsonData != null ? toJsonData(data!) : data,
    };
  }
}
