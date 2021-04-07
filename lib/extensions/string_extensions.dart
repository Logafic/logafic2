import 'package:logafic/data_model/routing_data.dart';

extension StringExtensions on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print('queryParameters :${uriData.queryParameters} Path: ${uriData.path}');
    return RoutingData(
        queryParameters: uriData.queryParameters, route: uriData.path);
  }
}
