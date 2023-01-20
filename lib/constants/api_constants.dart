class ApiConstants {
  ApiConstants._();

  // /current.json?key=61d4b23f57864592897100158232001&q=Dhaka&aqi=no

  static const String _baseUrl = "https://api.weatherapi.com/v1";
  static const String currentWeather = "$_baseUrl/current.json";
  static const String searchCities = "$_baseUrl/search.json";
}
