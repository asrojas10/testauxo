part of 'airline_bloc_bloc.dart';

abstract class AirlineBlocState extends Equatable {
  const AirlineBlocState();

  @override
  List<Object?> get props => [];
}

class AirlineBlocInitial extends AirlineBlocState {}

class AirlineLoaded extends AirlineBlocState {
  final List<Airline> airlines;

  const AirlineLoaded({required this.airlines});
  @override
  List<Object?> get props => [airlines];
}
