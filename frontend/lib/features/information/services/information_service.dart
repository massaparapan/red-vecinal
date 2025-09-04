import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/information/models/request/information_create_request.dart';
import 'package:frontend/features/information/models/response/information_response.dart';
import 'package:retrofit/retrofit.dart';

part 'information_service.g.dart';

@RestApi(baseUrl: "/api/informations")
abstract class InformationService {
  factory InformationService(Dio dio, {String baseUrl}) = _InformationService;

  factory InformationService.withDefaults() => InformationService(ApiClient.instance);

  @GET("/my-community")
  Future<List<InformationResponse>> getMyCommunityInformations();

  @POST("")
  Future<InformationResponse> createInformation(@Body() InformationCreateRequest information);

  @DELETE("/{id}")
  Future<void> deleteInformation(@Path("id") int id);
}
