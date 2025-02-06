import 'package:flutter/material.dart';
import 'package:house/components/custom_text_field.dart';

import 'package:house/models/city_model.dart';
import 'package:house/models/country_model.dart';
import 'package:house/viewmodels/property_view_model.dart';
import 'package:house/components/custom_dropdown_button.dart';
import 'package:house/components/custom_search_text_field.dart';

class PropertyFilterView extends StatelessWidget {
  final PropertyViewModel propertyViewModel;
  const PropertyFilterView({super.key, required this.propertyViewModel});

  @override
  Widget build(BuildContext context) {
    Country? propertyCountry = propertyViewModel.filterProperty.country;
    City? propertyCity = propertyViewModel.filterProperty.city;
    String? propertyType = propertyViewModel.filterProperty.propertyType;
    String? fromSurface = propertyViewModel.filterProperty.fromSurface;
    String? toSurface = propertyViewModel.filterProperty.toSurface;

    return Scaffold(
      appBar: AppBar(title: const Text("Filtrar propiedades")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomDropdownButton<String>(
              label: "Tipo",
              initialValue: propertyType,
              items: propertyViewModel.propertyTypes,
              onChanged: (value) => propertyType = value,
            ),
            const SizedBox(height: 8.0),
            CustomSearchTextField(
              labelText: "País",
              initialValue: propertyCountry,
              onChanged: (country) => propertyCountry = country as Country?,
              searchResults: propertyViewModel.countries,
            ),
            const SizedBox(height: 8.0),
            CustomSearchTextField(
              labelText: "Ciudad",
              initialValue: propertyCity,
              onChanged: (city) => propertyCity = city as City?,
              searchResults: propertyViewModel.cities,
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              labelText: "Superficie (Desde)",
              keyboardType: TextInputType.number,
              initialValue: fromSurface ?? '',
              onChanged: (value) =>
                  fromSurface = value.isNotEmpty ? value : null,
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              labelText: "Superficie (Hasta)",
              keyboardType: TextInputType.number,
              initialValue: toSurface ?? '',
              onChanged: (value) => toSurface = value.isNotEmpty ? value : null,
            ),
            const SizedBox(height: 16.0),
            TextButton.icon(
              onPressed: () {
                propertyViewModel.setFilter(
                  propertyCountry,
                  propertyCity,
                  propertyType,
                  fromSurface,
                  toSurface,
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text("Aplicar filtros"),
            ),
          ],
        ),
      ),
    );
  }
}
