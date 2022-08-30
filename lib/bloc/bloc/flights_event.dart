part of 'flights_bloc.dart';

abstract class FlightsEvent extends Equatable {
  const FlightsEvent();
  @override
  List<Object?> get props => [];
}

class LoadingFlights extends FlightsEvent {}

class UpdateFlights extends FlightsEvent {
  final List<Itinerary> itineraries;
  const UpdateFlights({required this.itineraries});

  @override
  List<Object?> get props => [itineraries];
}

class LoadingLegs extends FlightsEvent {}

class LoadingBoth extends FlightsEvent {
  final List<Leg> legs1;
  final List<Itinerary> itinerary1;

  const LoadingBoth({this.legs1 = const [], this.itinerary1 = const []});

  @override
  List<Object?> get props => [legs1, itinerary1];
}

class FilterFlightsByAgent extends FlightsEvent {
  final String filter;

  const FilterFlightsByAgent({required this.filter});

  @override
  List<Object?> get props => [filter];
}
