import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_auxo/bloc/airline/airline_bloc_bloc.dart';
import 'package:prueba_auxo/bloc/bloc/flights_bloc.dart';

class AirlineView extends StatelessWidget {
  const AirlineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: BlocBuilder<AirlineBlocBloc, AirlineBlocState>(
          builder: (context, state) {
            if (state is AirlineLoaded) {
              print('tamanho ${state.airlines.length}');
              return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            BlocProvider.of<AirlineBlocBloc>(context,
                                    listen: false)
                                .add(FilterAirlinesByName(filter: value));
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: SizedBox(
                            height: 500.0,
                            child: ListView.builder(
                              itemCount: state.airlines.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      child: SizedBox(
                                        width: 200,
                                        height: 75,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                  '${state.airlines[index].name}'),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                  'Number of itineraries: ${state.airlines[index].numLegs}')
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                                ;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            } else {
              return Center(child: Text('No hay lista'));
            }
          },
        ),
      ),
    );
  }
}
