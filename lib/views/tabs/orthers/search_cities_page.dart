import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_bee/providers/city_provider.dart';

class SearchCitiesPage extends ConsumerStatefulWidget {
  const SearchCitiesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchCitiesPageState();
}

class _SearchCitiesPageState extends ConsumerState<SearchCitiesPage> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final citiesRef = ref.watch(citySearchProvider(
        _searchController.text.isEmpty ? null : _searchController.text));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Cities'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (value.length > 2) {
                  setState(() {});
                } else if (value.isEmpty) {
                  setState(() {});
                }
              },
            ),
          ),
          Expanded(
            child: citiesRef.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(child: Text("Search for a city"));
                } else {
                  return ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].name),
                        subtitle: Text(data[index].country),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pop(context, data[index].name);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
                }
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
