import 'dart:async';
import 'package:artyom_assignment/Blocs/Locations/LocationsEvents.dart';
import 'package:artyom_assignment/Blocs/Locations/LocationsStates.dart';
import 'package:artyom_assignment/Handlers/ApiHandler.dart';
import 'package:artyom_assignment/Models/Location.dart';
import 'package:bloc/bloc.dart';

class LocationsBloc extends Bloc<LocationsEvents, LocationsStates> {
  ApiHandler apiHandler = ApiHandler();

  LocationsBloc(LocationsStates initialState) : super(initialState);

  //MARK: - Bloc
  @override
  Stream<LocationsStates> mapEventToState(LocationsEvents event) async* {
    yield LoadingLocationsState();

    if (event is FetchAllLocationsEvent) {
      String query = r'''
      query {
        locations(page: 1) {
          results {
            id,
            name,
            type
          }
        }
      }
      ''';

      try {
        final result = await apiHandler.performQuery(query, variables: {});

        if (result.hasException) {
          print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
          print('clientErrors: ${result.exception.clientException.toString()}');
          yield ErrorLocationsState(err: result.exception.graphqlErrors[0]);
        } else {
          List<Location> locations = [];
          for (var data in result.data['locations']['results']) {
            locations.add(Location.fromData(data));
          }
          
          yield LoadedSuccessfullyLocationsState(content: locations);
        }
      } catch (e) {
        print(e);
        yield ErrorLocationsState(err: e.toString());
      }
    } else if (event is FetchLocation) {
      String query = r'''
      query {
        location(id: ''' + event.id + ''') {
          id,
          name,
          type
        }
      }
      ''';

      try {
        final result = await apiHandler.performQuery(query, variables: {});

        if (result.hasException) {
          print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
          print('clientErrors: ${result.exception.clientException.toString()}');
          yield ErrorLocationsState(err: result.exception.graphqlErrors[0]);
        } else {
          final location = Location.fromData(result.data);
          yield LoadedSuccessfullyLocationsState(content: location);
        }
      } catch (e) {
        print(e);
        yield ErrorLocationsState(err: e.toString());
      }
    }
  }
}
