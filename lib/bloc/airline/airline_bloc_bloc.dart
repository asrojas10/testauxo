import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_auxo/model/airline.dart';
import 'package:prueba_auxo/repository/flightsDB.dart';

part 'airline_bloc_event.dart';
part 'airline_bloc_state.dart';

class AirlineBlocBloc extends Bloc<AirlineBlocEvent, AirlineBlocState> {
  AirlineBlocBloc() : super(AirlineBlocInitial()) {
    on<LoadingAirlines>(_loadingAirlines);
    on<FilterAirlinesByName>(_loadingFilter);
  }

  void _loadingAirlines(
      LoadingAirlines event, Emitter<AirlineBlocState> emitter) async {
    final listaAirlines = await FlightsDB.instance.getAirlines();
    emit(AirlineLoaded(airlines: listaAirlines));
  }

  void _loadingFilter(
      FilterAirlinesByName event, Emitter<AirlineBlocState> emitter) async {
    if (event.filter != "") {
      List<Airline> x = (state.props[0] as List<Airline>)
          .where((element) =>
              element.name.toLowerCase().contains(event.filter.toLowerCase()))
          .toList();
      emit(AirlineLoaded(airlines: x));
    } else {
      print("entra");
      final listaAirlines = await FlightsDB.instance.getAirlines();
      emit(AirlineLoaded(airlines: listaAirlines));
    }
  }
}
