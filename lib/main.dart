import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_auxo/bloc/airline/airline_bloc_bloc.dart';
import 'package:prueba_auxo/bloc/bloc/flights_bloc.dart';
import 'package:prueba_auxo/repository/flights_repository.dart';
import 'package:prueba_auxo/view/airline_view.dart';
import 'package:prueba_auxo/view/itinerary_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FlightsBloc>(
            create: (context) =>
                FlightsBloc(flightRepository: FlightsRepository())
                  ..add(LoadingFlights())
                  ..add(LoadingBoth()),
          ),
          BlocProvider<AirlineBlocBloc>(create: (context) => AirlineBlocBloc()),
        ],
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text("Auxo Test"),
            ),
            body: Container(
              child: BlocBuilder<FlightsBloc, FlightsState>(
                builder: (context, state) {
                  if (state is BothLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) {
                                BlocProvider.of<FlightsBloc>(context,
                                        listen: false)
                                    .add(FilterFlightsByAgent(filter: value));
                              },
                            ),
                            Center(
                                child: SizedBox(
                              height: 500.0,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.itinerary1.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                          leading: const Icon(Icons.flight),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.black, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                              return ItineraryView(
                                                  itinerary:
                                                      state.itinerary1[index],
                                                  leg1: state.legs1
                                                      .where((element) =>
                                                          element.id ==
                                                          state
                                                              .itinerary1[index]
                                                              .leg1)
                                                      .first,
                                                  leg2: state.legs1
                                                      .where((element) =>
                                                          element.id ==
                                                          state
                                                              .itinerary1[index]
                                                              .leg2)
                                                      .first);
                                            }));
                                          },
                                          title: Text(
                                              "Itinerary id: ${state.itinerary1[index].id}")),
                                    );
                                  }),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 75.0),
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<AirlineBlocBloc>(context,
                                          listen: false)
                                      .add(LoadingAirlines(airlines: []));
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AirlineView();
                                  }));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Go to Airline List",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.airlines,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('No hay lista'));
                  }
                },
              ),
            ),
          ),
        ));
  }
}
