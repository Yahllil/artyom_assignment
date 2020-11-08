abstract class LocationsEvents {}

//Fetch all locations
class FetchAllLocationsEvent extends LocationsEvents {}

//Fetch a specific location
class FetchLocation extends LocationsEvents {
  final String id;

  FetchLocation({this.id});
}