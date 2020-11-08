import 'package:artyom_assignment/Blocs/Episodes/EpisodesBloc.dart';
import 'package:artyom_assignment/Blocs/Episodes/EpisodesEvents.dart';
import 'package:artyom_assignment/Blocs/Episodes/EpisodesStates.dart';
import 'package:artyom_assignment/Models/Episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EpisodesScreen extends StatelessWidget {
  List<Episode> episodes = [];

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
      create: (BuildContext context) => EpisodesBloc(LoadingEpisodesState())..add(FetchAllEpisodesEvent()),
      child: BlocBuilder<EpisodesBloc, EpisodesStates>(
        builder: (BuildContext context, EpisodesStates state) {
          if(state is LoadingEpisodesState) {
            return _buildLoadingIndicator();
          } else if(state is LoadedSuccessfullyEpisodesState) {
            episodes = state.content;

            return _buildListView(); 
          } else if(state is ErrorEpisodesState) {
            return Text(state.err);
          }

          return Text('Unknown');
        },
        
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        return _buildListTile(
          title: episodes[index].name,
          subtitle: episodes[index].airDate,
          onPressed: (){
            print('pressed');
          }
        );
      }
    );
  }

  Widget _buildListTile({@required String title, @required String subtitle, String imageURL, Function onPressed}) {
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
          // leading: CircleAvatar(
          //   radius: 20,
          //   backgroundImage: NetworkImage(imageURL)
          // ),
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