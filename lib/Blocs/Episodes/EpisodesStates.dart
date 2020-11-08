abstract class EpisodesStates {}

class LoadingEpisodesState extends EpisodesStates {}

class LoadedSuccessfullyEpisodesState extends EpisodesStates {
  final dynamic content;

  LoadedSuccessfullyEpisodesState({this.content}) : super();
}

class ErrorEpisodesState extends EpisodesStates {
  final dynamic err;

  ErrorEpisodesState({this.err}) : super();
}