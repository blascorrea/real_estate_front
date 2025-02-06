import 'package:house/utils/search_result.dart';

List<City> citiesFromJson(List data) =>
    List<City>.from(data.map((c) => City.fromJson(c)));

class City extends SearchResult {
  City(super.id, super.name);

  factory City.fromJson(Map<String, dynamic> json) =>
      City(json["id"], json["name"]);
}
