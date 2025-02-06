import 'package:house/utils/search_result.dart';

List<Country> countryFromJson(List data) =>
    List<Country>.from(data.map((c) => Country.fromJson(c)));

class Country extends SearchResult {
  Country(super.id, super.name);

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(json["id"], json["name"]);
}
