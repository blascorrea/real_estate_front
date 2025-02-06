import 'dart:io';
import 'package:dio/dio.dart';

import 'package:house/models/property_model.dart';
import 'package:house/utils/constants.dart';

class PropertyService {
  final dio = Dio();

  PropertyService() {
    dio.options = BaseOptions(baseUrl: BASE_URL);
  }

  Future<List<Property>> getAll(String? query) async {
    try {
      final url = query != null ? '$URL_PROPERTIES?$query' : URL_PROPERTIES;
      final response = await dio.get(url);
      return propertiesFromJson(response.data);
    } catch (e) {
      throw const HttpException("Hubo un error al conectar con el servidor...");
    }
  }

  Future<bool> create(Property property) async {
    try {
      await dio.post(URL_PROPERTIES, data: property.toJson());
      return true;
    } catch (e) {
      throw const HttpException("Hubo un error al conectar con el servidor...");
    }
  }

  Future<bool> update(Property property) async {
    try {
      final url = '$URL_PROPERTIES/${property.id}';
      await dio.put(url, data: property.toJson());
      return true;
    } catch (e) {
      throw const HttpException("Hubo un error al conectar con el servidor...");
    }
  }

  Future<bool> delete(int id) async {
    try {
      await dio.delete('$URL_PROPERTIES/$id');
      return true;
    } catch (e) {
      throw const HttpException("Hubo un error al conectar con el servidor...");
    }
  }
}
