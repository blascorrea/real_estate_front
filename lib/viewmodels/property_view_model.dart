import 'dart:io';

import 'package:flutter/material.dart';

import 'package:house/models/city_model.dart';
import 'package:house/models/country_model.dart';
import 'package:house/models/property_model.dart';
import 'package:house/repositories/city_repository.dart';
import 'package:house/repositories/country_repository.dart';
import 'package:house/repositories/property_repository.dart';
import 'package:house/utils/filter_property.dart';
import 'package:house/utils/response.dart';

class PropertyViewModel extends ChangeNotifier {
  final PropertyRepository repository;
  final CityRepository cityRepository;
  final CountryRepository countryRepository;
  String? searchFilter;
  bool isLoading = false;
  List<Property> _properties = [];
  List<Property> get properties => _properties;
  FilterProperty filterProperty = FilterProperty();

  List<Country> countries = [];
  List<City> cities = [];
  List<String> propertyTypes = [
    "Casa",
    "Apartamento",
    "Oficina",
    "Lote",
    "Local"
  ];

  Property? selectedProperty;

  void setSelectedProperty(Property? property) {
    selectedProperty = property;
  }

  PropertyViewModel(
      this.repository, this.cityRepository, this.countryRepository) {
    fetchAllProperties();
  }

  void setFilter(
    Country? country,
    City? city,
    String? propertyType,
    String? fromSurface,
    String? toSurface,
  ) {
    filterProperty.country = country;
    filterProperty.city = city;
    filterProperty.propertyType = propertyType;
    filterProperty.fromSurface = fromSurface;
    filterProperty.toSurface = toSurface;
    fetchAllProperties();
  }

  void setSearchFilter(String? filter) {
    searchFilter = filter;
    fetchAllProperties();
  }

  String? filterRange() {
    final filterRange = filterProperty.fromSurface != null &&
            filterProperty.toSurface != null
        ? 'Entre ${filterProperty.fromSurface} - ${filterProperty.toSurface}'
        : filterProperty.fromSurface != null
            ? 'Mayor ${filterProperty.fromSurface}'
            : filterProperty.toSurface != null
                ? 'Menor que ${filterProperty.toSurface}'
                : null;

    return filterRange != null ? 'Superficie: $filterRange' : null;
  }

  void removeFilter(filter) {
    switch (filter) {
      case "country":
        filterProperty.country = null;
        break;
      case "city":
        filterProperty.city = null;
        break;
      case "type":
        filterProperty.propertyType = null;
      case "surface":
        filterProperty.fromSurface = null;
        filterProperty.toSurface = null;
        break;
      default:
    }
    fetchAllProperties();
  }

  String? getQuery() {
    if (searchFilter != null ||
        filterProperty.country != null ||
        filterProperty.city != null ||
        filterProperty.propertyType != null ||
        filterProperty.fromSurface != null ||
        filterProperty.toSurface != null) {
      bool queryAdd = searchFilter != null;
      String query = queryAdd ? 'search=$searchFilter' : '';
      if (filterProperty.country != null) {
        if (queryAdd) {
          query += '&country=${filterProperty.country!.id}';
        } else {
          query += 'country=${filterProperty.country!.id}';
          queryAdd = true;
        }
      }
      if (filterProperty.city != null) {
        if (queryAdd) {
          query += '&city=${filterProperty.city!.id}';
        } else {
          query += 'city=${filterProperty.city!.id}';
          queryAdd = true;
        }
      }
      if (filterProperty.propertyType != null) {
        if (queryAdd) {
          query += '&propertyType=${filterProperty.propertyType}';
        } else {
          query += 'propertyType=${filterProperty.propertyType}';
          queryAdd = true;
        }
      }
      if (filterProperty.fromSurface != null) {
        if (queryAdd) {
          query += '&fromSurface=${filterProperty.fromSurface}';
        } else {
          query += 'fromSurface=${filterProperty.fromSurface}';
          queryAdd = true;
        }
      }
      if (filterProperty.toSurface != null) {
        if (queryAdd) {
          query += '&toSurface=${filterProperty.toSurface}';
        } else {
          query += 'toSurface=${filterProperty.toSurface}';
        }
      }
      return query;
    }

    return null;
  }

  Future<void> fetchAllProperties() async {
    if (countries.isEmpty) countries = await countryRepository.getAll(null);
    if (cities.isEmpty) cities = await cityRepository.getAll(null);
    _properties = await repository.getAll(getQuery());
    notifyListeners();
  }

  Future<ResponseBase> createOrUpdateProperty({
    required String name,
    required String address,
    required String propertyType,
    required double surface,
    required Country country,
    required City city,
    String? zipCode,
  }) async {
    final property = Property(
      name: name,
      address: address,
      propertyType: propertyType,
      surface: surface,
      zipCode: zipCode,
      country: country,
      city: city,
    );
    bool result;

    try {
      if (selectedProperty == null) {
        result = await repository.create(property);
      } else {
        property.id = selectedProperty?.id;
        result = await repository.update(property);
      }
      if (result) {
        await fetchAllProperties();
      }
      return ResponseSucces(selectedProperty != null
          ? "Propiedad actualizada con éxito"
          : "Propiedad Creada con éxito");
    } on HttpException catch (exc) {
      return ResponseFailure(exc.message);
    }
  }

  Future<bool> deleteProperty() async {
    final result = await repository.delete(selectedProperty!.id!);
    if (result) {
      await fetchAllProperties();
    }

    return result;
  }
}
