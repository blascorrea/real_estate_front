import 'package:flutter/material.dart';

import 'package:house/models/city_model.dart';
import 'package:house/models/country_model.dart';
import 'package:house/utils/response.dart';
import 'package:house/viewmodels/property_view_model.dart';
import 'package:house/components/custom_dropdown_button.dart';
import 'package:house/components/custom_text_field.dart';
import 'package:house/components/custom_search_text_field.dart';

class PropertyEditView extends StatelessWidget {
  PropertyViewModel propertyViewModel;
  PropertyEditView({super.key, required this.propertyViewModel});

  final _formKey = GlobalKey<FormState>();

  void _showToast(BuildContext context, String message,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? propertyName = propertyViewModel.selectedProperty?.name;
    String? propertyAddress = propertyViewModel.selectedProperty?.address;
    String? propertyZipCode = propertyViewModel.selectedProperty?.zipCode;
    double? propertySurface = propertyViewModel.selectedProperty?.surface ?? 0;
    Country? propertyCountry = propertyViewModel.selectedProperty?.country;
    City? propertyCity = propertyViewModel.selectedProperty?.city;
    String? propertyType = propertyViewModel.selectedProperty?.propertyType;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
              propertyName != null ? 'Editar $propertyName...' : 'Nueva propiedad'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomTextField(
                labelText: "Nombre",
                initialValue: propertyName ?? '',
                onChanged: (value) => propertyName = value,
                requiredField: true,
              ),
              const SizedBox(height: 8.0),
              CustomTextField(
                labelText: "Dirección",
                initialValue: propertyAddress ?? '',
                onChanged: (value) => propertyAddress = value,
                requiredField: true,
              ),
              const SizedBox(height: 8.0),
              CustomDropdownButton<String>(
                label: "Tipo",
                initialValue: propertyType,
                items: propertyViewModel.propertyTypes,
                onChanged: (value) => propertyType = value,
                requiredField: true,
              ),
              const SizedBox(height: 8.0),
              CustomTextField(
                labelText: "Superficie",
                initialValue: (propertySurface).toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    propertySurface = double.parse(value.isEmpty ? "0" : value),
                requiredField: true,
              ),
              const SizedBox(height: 8.0),
              CustomTextField(
                labelText: "Código postal",
                initialValue: propertyZipCode ?? '',
                keyboardType: TextInputType.number,
                onChanged: (value) => propertyZipCode = value,
              ),
              const SizedBox(height: 8.0),
              CustomSearchTextField(
                labelText: "País",
                initialValue: propertyCountry,
                onChanged: (country) => propertyCountry = country as Country?,
                searchResults: propertyViewModel.countries,
                requiredField: true,
              ),
              const SizedBox(height: 8.0),
              CustomSearchTextField(
                labelText: "Ciudad",
                initialValue: propertyCity,
                onChanged: (city) => propertyCity = city as City?,
                searchResults: propertyViewModel.cities,
                requiredField: true,
              ),
              const SizedBox(height: 16.0),
              if (propertyViewModel.selectedProperty != null)
                TextButton.icon(
                  onPressed: () async {
                    final delete = await showDialog<bool>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("¿Desea eliminar la propiedad?"),
                            content: const Text("Por favor confirme la acción"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("Cancelar")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("Aceptar")),
                            ],
                          );
                        });
                    if (delete != null && delete) {
                      final result = await propertyViewModel.deleteProperty();
                      if (result) {
                        Navigator.of(context).pop();
                        _showToast(context, "Propiedad eliminada...");
                      }
                    }
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Eliminar propiedad"),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              ResponseBase result =
                  await propertyViewModel.createOrUpdateProperty(
                name: propertyName!,
                address: propertyAddress!,
                propertyType: propertyType!,
                surface: propertySurface!,
                country: propertyCountry!,
                city: propertyCity!,
                zipCode: propertyZipCode,
              );
              if (!result.error) {
                Navigator.of(context).pop();
                _showToast(
                  context,
                  result.message,
                  backgroundColor: Colors.green,
                );
              } else {
                _showToast(
                  context,
                  result.message,
                  backgroundColor: Colors.red,
                );
              }
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
