import 'package:house/models/city_model.dart';
import 'package:house/models/country_model.dart';

List<Property> propertiesFromJson(List data) =>
    List<Property>.from(data.map((p) => Property.fromJson(p)));

class Property {
  Property({
    this.id,
    required this.name,
    required this.address,
    required this.propertyType,
    required this.surface,
    required this.country,
    required this.city,
    this.zipCode,
  });

  int? id;
  String? zipCode;
  String name;
  String address;
  String propertyType;
  double surface;
  Country country;
  City city;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "propertyType": propertyType,
        "surface": surface,
        "zipCode": zipCode,
        "countryId": country.id,
        "cityId": city.id,
      };

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        propertyType: json["propertyType"],
        surface: double.parse(json["surface"].toString()),
        zipCode: json["zipCode"],
        country: Country(json["country"]["id"], json["country"]["name"]),
        city: City(json["city"]["id"], json["city"]["name"]),
      );
  }
}
