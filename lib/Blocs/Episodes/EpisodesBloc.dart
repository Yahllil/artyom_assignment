import 'dart:async';
import 'package:artyom_assignment/Blocs/Episodes/EpisodesEvents.dart';
import 'package:artyom_assignment/Blocs/Episodes/EpisodesStates.dart';
import 'package:artyom_assignment/Handlers/ApiHandler.dart';
import 'package:artyom_assignment/Models/Episode.dart';
import 'package:bloc/bloc.dart';

class EpisodesBloc extends Bloc<EpisodesEvents, EpisodesStates> {
  ApiHandler apiHandler = ApiHandler();

  EpisodesBloc(EpisodesStates initialState) : super(initialState);

  //MARK: - Bloc
  @override
  Stream<EpisodesStates> mapEventToState(EpisodesEvents event) async* {
    yield LoadingEpisodesState();

    if (event is FetchAllEpisodesEvent) {
      String query = r'''
      query {
        episodes(page: 1) {
          results {
            id,
            name,
            air_date
          }
        }
      }
      ''';

      try {
        final result = await apiHandler.performQuery(query, variables: {});

        if (result.hasException) {
          print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
          print('clientErrors: ${result.exception.clientException.toString()}');
          yield ErrorEpisodesState(err: result.exception.graphqlErrors[0]);
        } else {
          List<Episode> episodes = [];
          for (var data in result.data['episodes']['results']) {
            episodes.add(Episode.fromData(data));
          }
          
          yield LoadedSuccessfullyEpisodesState(content: episodes);
        }
      } catch (e) {
        print(e);
        yield ErrorEpisodesState(err: e.toString());
      }
    } else if (event is FetchEpisode) {
      String query = r'''
      query {
        episode(id: ''' + event.id + ''') {
          id,
          name,
          air_date
        }
      }
      ''';

      try {
        final result = await apiHandler.performQuery(query, variables: {});

        if (result.hasException) {
          print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
          print('clientErrors: ${result.exception.clientException.toString()}');
          yield ErrorEpisodesState(err: result.exception.graphqlErrors[0]);
        } else {
          final episode = Episode.fromData(result.data);
          yield LoadedSuccessfullyEpisodesState(content: episode);
        }
      } catch (e) {
        print(e);
        yield ErrorEpisodesState(err: e.toString());
      }
    }
  }
}
