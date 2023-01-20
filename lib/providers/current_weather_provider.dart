import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:weather_bee/constants/api_constants.dart';
import 'package:weather_bee/constants/app_constants.dart';
import 'package:weather_bee/models/current_weather_model.dart';

final currentWeatherProvider =
    FutureProvider.family<CurrentWeatherModel?, String?>((ref, city) async {
  if (city == null) {
    return null;
  } else {
    final params = {
      "key": AppConstants.weatherAPIkey,
      "q": city,
      "aqi": "no",
    };
    Uri url = Uri.parse(ApiConstants.currentWeather);
    url = url.replace(queryParameters: params);

    final response = await get(url);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return CurrentWeatherModel.fromJson(responseJson);
    } else {
      return null;
    }
  }
});
