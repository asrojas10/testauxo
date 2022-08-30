import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba_auxo/model/itinerary.dart';
import 'package:prueba_auxo/model/leg.dart';
import 'package:prueba_auxo/repository/flightsDB.dart';

class FlightsRepository {
  final baseUrl =
      'https://raw.githubusercontent.com/Skyscanner/full-stack-recruitment-test/main/public/flights.json';

  Future getFlights() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonFlights = jsonDecode(response.body);
        return jsonFlights;
      } else {
        throw Exception("No DATA");
      }
    } catch (e) {
      print('Repository: ${e}');
    }
  }

  Future getAll<T>() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      var i = 0;
      while (i < json['legs'].length) {
        await FlightsDB.instance.addLeg(Leg.fromJson(json['legs'][i]));
        i++;
      }
      i = 0;
      while (i < json['itineraries'].length) {
        await FlightsDB.instance
            .addItinerary(Itinerary.fromJson(json['itineraries'][i]));
        i++;
      }
    } else {
      throw Exception('Failed to load album');
    }
  }
}
