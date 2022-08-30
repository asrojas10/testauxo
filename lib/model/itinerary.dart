class Itinerary {
  final String id;
  final String price;
  final String agent;
  final double agent_rating;
  final String leg1;
  final String leg2;

  Itinerary(
      {required this.id,
      required this.price,
      required this.agent,
      required this.agent_rating,
      required this.leg1,
      required this.leg2});
  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
      id: json['id'],
      price: json['price'],
      agent: json['agent'],
      agent_rating: json['agent_rating'],
      leg1: json['legs'][0],
      leg2: json['legs'][1]);

  factory Itinerary.fromSql(Map<String, dynamic> json) => Itinerary(
      id: json['id'],
      price: json['price'],
      agent: json['agent'],
      agent_rating: json['agent_rating'],
      leg1: json['leg1'],
      leg2: json['leg2']);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['id'] = this.id;
    data['price'] = this.price;
    data['agent'] = this.agent;
    data['agent_rating'] = this.agent_rating;
    data['leg1'] = this.leg1;
    data['leg2'] = this.leg2;

    return data;
  }
}
