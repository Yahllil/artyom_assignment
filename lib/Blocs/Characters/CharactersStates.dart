abstract class CharactersStates {}

class LoadingCharactersState extends CharactersStates {}

class LoadedSuccessfullyCharactersState extends CharactersStates {
  final dynamic content;

  LoadedSuccessfullyCharactersState({this.content}) : super();
}

class ErrorCharactersState extends CharactersStates {
  final dynamic err;

  ErrorCharactersState({this.err}) : super();
}