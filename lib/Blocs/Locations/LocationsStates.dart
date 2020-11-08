abstract class LocationsStates {}

class LoadingLocationsState extends LocationsStates {}

class LoadedSuccessfullyLocationsState extends LocationsStates {
  final dynamic content;

  LoadedSuccessfullyLocationsState({this.content}) : super();
}

class ErrorLocationsState extends LocationsStates {
  final dynamic err;

  ErrorLocationsState({this.err}) : super();
}