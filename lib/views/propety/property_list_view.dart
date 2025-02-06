import 'package:flutter/material.dart';
import 'package:house/components/custom_chip_filter.dart';
import 'package:house/viewmodels/property_view_model.dart';
import 'package:house/views/propety/property_edit_view.dart';
import 'package:house/views/propety/property_filter_view.dart';
import 'package:provider/provider.dart';

class PropertyListView extends StatelessWidget {
  const PropertyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyViewModel = Provider.of<PropertyViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) =>
                          {propertyViewModel.setSearchFilter(value)},
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Buscar...",
                        border: InputBorder.none,
                        suffixIcon: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PropertyFilterView(
                                  propertyViewModel: propertyViewModel,
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.filter_list_alt),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (propertyViewModel.filterProperty.country != null ||
                propertyViewModel.filterProperty.city != null ||
                propertyViewModel.filterProperty.propertyType != null ||
                propertyViewModel.filterRange() != null)
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 8),
                    if (propertyViewModel.filterProperty.country != null)
                      CustomChipFilter(
                        label: Text(
                            "País: ${propertyViewModel.filterProperty.country!.name}"),
                        onDeleted: () {
                          propertyViewModel.removeFilter("country");
                        },
                      ),
                    if (propertyViewModel.filterProperty.city != null)
                      CustomChipFilter(
                        label: Text(
                            "Ciudad: ${propertyViewModel.filterProperty.city!.name}"),
                        onDeleted: () {
                          propertyViewModel.removeFilter("city");
                        },
                      ),
                    if (propertyViewModel.filterProperty.propertyType != null)
                      CustomChipFilter(
                        label: Text(
                            "Tipo: ${propertyViewModel.filterProperty.propertyType!}"),
                        onDeleted: () {
                          propertyViewModel.removeFilter("type");
                        },
                      ),
                    if (propertyViewModel.filterRange() != null)
                      CustomChipFilter(
                        label: Text(propertyViewModel.filterRange()!),
                        onDeleted: () {
                          propertyViewModel.removeFilter("surface");
                        },
                      ),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: propertyViewModel.properties.length,
                itemBuilder: (context, index) {
                  final property = propertyViewModel.properties[index];
                  return ListTile(
                    title: Text(property.name),
                    subtitle: Text("${property.city.name}, ${property.country.name}"),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        property.propertyType.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      propertyViewModel.setSelectedProperty(property);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PropertyEditView(
                            propertyViewModel: propertyViewModel,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Agregar propiedad",
        onPressed: () async {
          propertyViewModel.setSelectedProperty(null);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PropertyEditView(
                propertyViewModel: propertyViewModel,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
