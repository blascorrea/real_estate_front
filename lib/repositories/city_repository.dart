import 'package:house/models/city_model.dart';
import 'package:house/repositories/base_repository.dart';
import 'package:house/services/city_service.dart';

class CityRepository extends Repository<City> {

  final CityService _cityService;
  CityRepository(this._cityService);
  
  @override
  Future<bool> create(City t) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<City>> getAll(String? query) {
    return _cityService.getAll();
  }
  
  @override
  Future<bool> update(City t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}