import 'dart:async';
import 'package:artyom_assignment/Blocs/Characters/CharactersEvents.dart';
import 'package:artyom_assignment/Blocs/Characters/CharactersStates.dart';
import 'package:artyom_assignment/Handlers/ApiHandler.dart';
import 'package:artyom_assignment/Models/Character.dart';
import 'package:bloc/bloc.dart';

class CharactersBloc extends Bloc<CharactersEvents, CharactersStates> {
  ApiHandler apiHandler = ApiHandler();

  CharactersBloc(CharactersStates initialState) : super(initialState);

  //MARK: - Bloc
  @override
  Stream<CharactersStates> mapEventToState(CharactersEvents event) async* {
    yield LoadingCharactersState();

    if (event is FetchAllCharactersEvent) {
      String query = r'''
      query {
        characters(page: 1) {
          results {
            id,
            name,
            image,
            species
          }
        }
      }
      ''';

      try {
        final result = await apiHandler.performQuery(query, variables: {});

        if (result.hasException) {
          print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
          print('clientErrors: ${result.exception.clientException.toString()}');
          yield ErrorCharactersState(err: result.exception.graphqlErrors[0]);
        } else {
          List<Character> characters = [];
          for (var data in result.data['characters']['results']) {
            characters.add(Character.fromData(data));
          }
          
          yield LoadedSuccessfullyCharactersState(content: characters);
        }
      } catch (e) {
        print(e);
        yield ErrorCharactersState(err: e.toString());
      }
    } else if (event is FetchCharacter) {
      String query = r'''
      query {
        character(id: ''' + event.id + ''') {
          id,
          name,
          image,
          species,
        }
      }
      ''';

      try {
        final result = await apiHandler.performQuery(query, variables: {});

        if (result.hasException) {
          print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
          print('clientErrors: ${result.exception.clientException.toString()}');
          yield ErrorCharactersState(err: result.exception.graphqlErrors[0]);
        } else {
          final character = Character.fromData(result.data);
          yield LoadedSuccessfullyCharactersState(content: character);
        }
      } catch (e) {
        print(e);
        yield ErrorCharactersState(err: e.toString());
      }
    }
  }
}
