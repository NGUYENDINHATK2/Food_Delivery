import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../apis/api_client.dart';

class RecommenededProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommenededProductRepo({required this.apiClient});

  Future<Response> getRecommenededProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
