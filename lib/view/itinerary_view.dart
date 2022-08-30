import 'package:flutter/material.dart';
import 'package:prueba_auxo/model/itinerary.dart';
import 'package:prueba_auxo/model/leg.dart';

class ItineraryView extends StatelessWidget {
  final Itinerary itinerary;
  final Leg leg1;
  final Leg leg2;
  const ItineraryView(
      {Key? key,
      required this.itinerary,
      required this.leg1,
      required this.leg2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Card(
          child: SizedBox(
            width: 350,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Agent: ${itinerary.agent}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'Price: ${itinerary.price}',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Agent Rating: ${itinerary.agent_rating}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Leg 1',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Text('Airline id: ${leg1.airline_id}'),
                          Text('Airline name: ${leg1.airline_name}'),
                          Text('Arrival AP: ${leg1.arrival_airport}'),
                          Text('Dep AP: ${leg1.departure_airport}'),
                          Text('Arrival time: ${leg1.arrival_time}'),
                          Text('Dep time: ${leg1.departure_time}'),
                          Text('Duration: ${leg1.duration_mins}')
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Leg 2',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Text('Airline id: ${leg2.airline_id}'),
                          Text('Airline name: ${leg2.airline_name}'),
                          Text('Arrival AP: ${leg2.arrival_airport}'),
                          Text('Dep AP: ${leg2.departure_airport}'),
                          Text('Arrival time: ${leg2.arrival_time}'),
                          Text('Dep time: ${leg2.departure_time}'),
                          Text('Duration: ${leg2.duration_mins}')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
