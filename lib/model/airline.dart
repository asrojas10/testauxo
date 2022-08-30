class Airline {
  String name;
  int numLegs;

  Airline({required this.name, required this.numLegs});

  factory Airline.fromSql(Map<String, dynamic> json) =>
      Airline(name: json['airline_name'], numLegs: json['COUNT(*)']);
}
