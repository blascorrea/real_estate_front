import 'package:dio/dio.dart';
import 'package:house/models/country_model.dart';

import 'package:house/utils/constants.dart';

class CountryService {

  final dio = Dio();
  
  CountryService() {
    dio.options = BaseOptions(baseUrl: BASE_URL);
  }

  Future<List<Country>> getAll() async {
    final response = await dio.get(URL_COUNTRIES);

    return countryFromJson(response.data);
  }
}
