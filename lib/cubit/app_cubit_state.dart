part of 'app_cubit.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WelcomeState extends CubitStates {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingState extends CubitStates {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedState extends CubitStates {
  final List<Place> places;

  LoadedState({required this.places});
  @override
  // TODO: implement props
  List<Object> get props => [places];
}

class DetailState extends CubitStates {
  final Place place;

  DetailState(this.place);

  @override
  // TODO: implement props
  List<Object> get props => [place];
}
