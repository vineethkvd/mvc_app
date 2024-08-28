import '../../../core/helpers/network/helpers/api_endpoints.dart';
import '../../../core/helpers/network/helpers/network_api_services.dart';

class StateRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> stateApi() async {
    dynamic response = await _apiService.getApi(ApiEndPoints.state);
    return response;
  }
}