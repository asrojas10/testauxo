class Leg {
  final String id;
  final String departure_airport;
  final String arrival_airport;
  final String arrival_time;
  final String departure_time;
  final int stops;
  final String airline_name;
  final String airline_id;
  final int duration_mins;

  Leg(
      {required this.id,
      required this.departure_airport,
      required this.arrival_airport,
      required this.arrival_time,
      required this.departure_time,
      required this.stops,
      required this.airline_name,
      required this.airline_id,
      required this.duration_mins});

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        id: json['id'],
        departure_airport: json['departure_airport'],
        arrival_airport: json['arrival_airport'],
        departure_time: json['departure_time'],
        arrival_time: json['arrival_time'],
        stops: json['stops'],
        airline_name: json['airline_name'],
        airline_id: json['airline_id'],
        duration_mins: json['duration_mins'],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['id'] = id;
    data['departure_airport'] = departure_airport;
    data['arrival_airport'] = arrival_airport;
    data['departure_time'] = departure_time;
    data['arrival_time'] = arrival_time;
    data['stops'] = stops;
    data['airline_name'] = airline_name;
    data['airline_id'] = airline_id;
    data['duration_mins'] = duration_mins;
    return data;
  }
}
