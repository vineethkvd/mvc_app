import '../../../core/helpers/network/helpers/api_endpoints.dart';
import '../../../core/helpers/network/helpers/network_api_services.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = await _apiService.postApi(
        data, ApiEndPoints.baseURL + ApiEndPoints.login);
    return response;
  }
}
