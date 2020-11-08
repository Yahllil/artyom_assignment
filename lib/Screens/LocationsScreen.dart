import 'package:artyom_assignment/Blocs/Locations/LocationsBloc.dart';
import 'package:artyom_assignment/Blocs/Locations/LocationsEvents.dart';
import 'package:artyom_assignment/Blocs/Locations/LocationsStates.dart';
import 'package:artyom_assignment/Models/Location.dart';
import 'package:artyom_assignment/Models/Location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationsScreen extends StatelessWidget {
  List<Location> locations = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: _buildScreenContent(),
    );
  }

  //MARK: - Widgets
  Widget _buildScreenContent() {
    return BlocProvider(
      create: (BuildContext context) => LocationsBloc(LoadingLocationsState())..add(FetchAllLocationsEvent()),
      child: BlocBuilder<LocationsBloc, LocationsStates>(
        builder: (BuildContext context, LocationsStates state) {
          if(state is LoadingLocationsState) {
            return _buildLoadingIndicator();
          } else if(state is LoadedSuccessfullyLocationsState) {
            locations = state.content;

            return _buildListView(); 
          } else if(state is ErrorLocationsState) {
            return Text(state.err);
          }

          return Text('Unknown');
        },
        
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return _buildListTile(
          title: locations[index].name,
          subtitle: locations[index].type,
          onPressed: (){
            print('pressed');
          }
        );
      }
    );
  }

  Widget _buildListTile({@required String title, @required String subtitle, Function onPressed}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(subtitle),
          onTap: onPressed,
        ),
      );
  }

  //MARK: - Private
  Widget _buildLoadingIndicator() {
    return SpinKitHourGlass(
      color: Colors.brown,
      size: 40,
    );
  }
}