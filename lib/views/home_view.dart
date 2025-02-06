import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:house/repositories/city_repository.dart';
import 'package:house/repositories/country_repository.dart';
import 'package:house/services/city_service.dart';
import 'package:house/services/country_service.dart';
import 'package:house/services/property_service.dart';
import 'package:house/repositories/property_repository.dart';
import 'package:house/viewmodels/home_view_model.dart';
import 'package:house/viewmodels/property_view_model.dart';
import 'package:house/views/propety/property_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PropertyViewModel(
            PropertyRepository(PropertyService()),
            CityRepository(CityService()),
            CountryRepository(CountryService()),
          ),
        ),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Real Estate"), centerTitle: true),
            body: IndexedStack(
              index: homeViewModel.currentIndex,
              children: const [
                PropertyListView(),
                Center(
                  child: Text("Ajustes..."),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: homeViewModel.currentIndex,
              onTap: (index) => homeViewModel.setIndex(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "Propiedades",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Ajustes",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
