import '../../../core/helpers/network/helpers/api_endpoints.dart';
import '../../../core/helpers/network/helpers/network_api_services.dart';

class DistrictRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> districtApi(var data) async {
    dynamic response = await _apiService.postApi(
        data, ApiEndPoints.testBaseURL + ApiEndPoints.district);
    return response;
  }
}