abstract class EpisodesEvents {}

//Fetch all episodes
class FetchAllEpisodesEvent extends EpisodesEvents {}

//Fetch a specific episode
class FetchEpisode extends EpisodesEvents {
  final String id;

  FetchEpisode({this.id});
}