abstract class CharactersEvents {}

//Fetch all characters
class FetchAllCharactersEvent extends CharactersEvents {}

//Fetch a specific characters
class FetchCharacter extends CharactersEvents {
  final String id;

  FetchCharacter({this.id});
}