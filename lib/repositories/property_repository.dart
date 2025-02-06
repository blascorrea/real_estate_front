import 'package:house/models/property_model.dart';
import 'package:house/repositories/base_repository.dart';
import 'package:house/services/property_service.dart';

class PropertyRepository extends Repository<Property> {

  final PropertyService _propertyService;
  PropertyRepository(this._propertyService);
  
  @override
  Future<bool> create(Property t) {
    return _propertyService.create(t);
  }

  @override
  Future<bool> delete(int id) {
    return _propertyService.delete(id);
  }

  @override
  Future<List<Property>> getAll(String? query) {
    return _propertyService.getAll(query);
  }

  @override
  Future<bool> update(Property t) {
    return _propertyService.update(t);
  }
}