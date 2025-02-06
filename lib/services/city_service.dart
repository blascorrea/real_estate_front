import 'package:dio/dio.dart';

import 'package:house/models/city_model.dart';
import 'package:house/utils/constants.dart';

class CityService {

  final dio = Dio();
  
  CityService() {
    dio.options = BaseOptions(baseUrl: BASE_URL);
  }

  Future<List<City>> getAll() async {
    final response = await dio.get(URL_CITIES);

    return citiesFromJson(response.data);
  }
}
