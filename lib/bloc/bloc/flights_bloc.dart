import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_auxo/model/airline.dart';
import 'package:prueba_auxo/model/itinerary.dart';
import 'package:prueba_auxo/model/leg.dart';
import 'package:prueba_auxo/repository/flightsDB.dart';
import 'package:prueba_auxo/repository/flights_repository.dart';

part 'flights_event.dart';
part 'flights_state.dart';

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {
  final FlightsRepository _flights_repository;
  FlightsBloc({required flightRepository})
      : _flights_repository = flightRepository,
        super(FlightsInitial()) {
    on<LoadingFlights>(_loadingFlights);
    on<LoadingBoth>(_loadingBoth);
    on<FilterFlightsByAgent>(_loadingFilter);
  }

  void _loadingFlights(
      LoadingFlights event, Emitter<FlightsState> emitter) async {
    await _flights_repository.getAll();
  }

  void _loadingBoth(LoadingBoth event, Emitter<FlightsState> emitter) async {
    final listaIt = await FlightsDB.instance.getItineraries();
    final listaLegs = await FlightsDB.instance.getLegs();
    emit(BothLoaded(legs1: listaLegs, itinerary1: listaIt));
  }

  void _loadingFilter(
      FilterFlightsByAgent event, Emitter<FlightsState> emitter) async {
    if (event.filter != "") {
      final listaLegs = await FlightsDB.instance.getLegs();
      List<Itinerary> x = (state.props[1] as List<Itinerary>)
          .where((element) =>
              element.id.toLowerCase().contains(event.filter.toLowerCase()))
          .toList();
      emit(BothLoaded(legs1: listaLegs, itinerary1: x));
    } else {
      final listaIt = await FlightsDB.instance.getItineraries();
      final listaLegs = await FlightsDB.instance.getLegs();
      emit(BothLoaded(legs1: listaLegs, itinerary1: listaIt));
    }
    ;
  }
}
