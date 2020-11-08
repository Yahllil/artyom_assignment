import 'package:artyom_assignment/Blocs/Characters/CharactersBloc.dart';
import 'package:artyom_assignment/Blocs/Characters/CharactersEvents.dart';
import 'package:artyom_assignment/Blocs/Characters/CharactersStates.dart';
import 'package:artyom_assignment/Models/Character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CharactersScreen extends StatelessWidget {
  List<Character> characters = [];

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
      create: (BuildContext context) => CharactersBloc(LoadingCharactersState())..add(FetchAllCharactersEvent()),
      child: BlocBuilder<CharactersBloc, CharactersStates>(
        builder: (BuildContext context, CharactersStates state) {
          if(state is LoadingCharactersState) {
            return _buildLoadingIndicator();
          } else if(state is LoadedSuccessfullyCharactersState) {
            characters = state.content;

            return _buildListView(); 
          } else if(state is ErrorCharactersState) {
            return Text(state.err);
          }

          return Text('Unknown');
        },
        
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return _buildListTile(
          title: characters[index].name,
          subtitle: characters[index].species,
          imageURL: characters[index].imageURL,
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
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(imageURL)
          ),
          onTap: onPressed,
        ),
      );
  }

  Widget _buildLoadingIndicator() {
    return SpinKitHourGlass(
      color: Colors.brown,
      size: 40,
    );
  }
}