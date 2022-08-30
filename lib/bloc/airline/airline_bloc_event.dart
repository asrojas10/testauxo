part of 'airline_bloc_bloc.dart';

abstract class AirlineBlocEvent extends Equatable {
  const AirlineBlocEvent();
  @override
  List<Object?> get props => [];
}

class LoadingAirlines extends AirlineBlocEvent {
  final List<Airline> airlines;

  const LoadingAirlines({required this.airlines});
  @override
  List<Object?> get props => [airlines];
}

class FilterAirlinesByName extends AirlineBlocEvent {
  final String filter;

  const FilterAirlinesByName({required this.filter});

  @override
  List<Object?> get props => [filter];
}
