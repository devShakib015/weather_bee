import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_bee/providers/current_weather_provider.dart';
import 'package:weather_bee/views/tabs/orthers/search_cities_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _cityName = "Dhaka";

  @override
  Widget build(BuildContext context) {
    final currentWeatherRef = ref.watch(currentWeatherProvider(_cityName));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const SearchCitiesPage();
              })).then((value) {
                if (value != null) {
                  setState(() {
                    _cityName = value;
                  });
                }
              });
            },
          ),
        ],
      ),
      body: currentWeatherRef.when(
        data: (data) {
          if (data != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  data.location.name,
                  textAlign: TextAlign.center,
                ),
                Text(
                  data.current.tempC.toString(),
                  textAlign: TextAlign.center,
                ), // Countr name
                Text(
                  data.location.country.toString(),
                  textAlign: TextAlign.center,
                ), // Countr name
              ],
            );
          } else {
            return const Center(child: Text("Something went wrong!"));
          }
        },
        error: (error, stackTrace) {
          print(stackTrace);
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
