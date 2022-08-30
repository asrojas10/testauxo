part of 'flights_bloc.dart';

abstract class FlightsState extends Equatable {
  const FlightsState();
  @override
  List<Object?> get props => [];
}

class FlightsInitial extends FlightsState {}

class FlightsLoaded extends FlightsState {
  final List<Itinerary> itineraries;
  const FlightsLoaded({required this.itineraries});

  @override
  List<Object?> get props => [itineraries];
}

class LegsLoaded extends FlightsState {
  final List<Leg> legs;
  const LegsLoaded({required this.legs});

  @override
  List<Object?> get props => [legs];
}

class BothLoaded extends FlightsState {
  final List<Leg> legs1;
  final List<Itinerary> itinerary1;

  const BothLoaded({required this.legs1, required this.itinerary1});

  @override
  List<Object?> get props => [legs1, itinerary1];
}
