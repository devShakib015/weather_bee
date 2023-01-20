import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:weather_bee/constants/api_constants.dart';
import 'package:weather_bee/constants/app_constants.dart';
import 'package:weather_bee/models/city_model.dart';

final citySearchProvider =
    FutureProvider.family<List<CityModel>, String?>((ref, query) async {
  if (query == null) {
    return [];
  }
  {
    final params = {
      "key": AppConstants.weatherAPIkey,
      "q": query,
    };

    Uri url = Uri.parse(ApiConstants.searchCities);
    url = url.replace(queryParameters: params);

    final response = await get(url);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return List<CityModel>.from(
          responseJson.map((x) => CityModel.fromJson(x)));
    } else {
      return [];
    }
  }
});
