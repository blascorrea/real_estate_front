import 'package:house/models/country_model.dart';
import 'package:house/repositories/base_repository.dart';
import 'package:house/services/country_service.dart';

class CountryRepository extends Repository<Country> {

  final CountryService _countryService;
  CountryRepository(this._countryService);
  
  @override
  Future<bool> create(Country t) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<Country>> getAll(String? query) {
    return _countryService.getAll();
  }
  
  @override
  Future<bool> update(Country t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}