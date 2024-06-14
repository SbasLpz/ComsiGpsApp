class LocationModel {
  int? id;
  String? lat;
  String? long;

  LocationModel({
    required this.id,
    required this.lat,
    required this.long
  });

  static List<LocationModel> locationsList() {
    return [
      LocationModel(id: 0, lat: "9.995263", long: "-84.157977"),
      LocationModel(id: 1, lat: "9.994724", long: "-84.158696"),
      LocationModel(id: 2, lat: "9.996246", long: "-84.159104"),
      LocationModel(id: 3, lat: "9.997873", long: "-84.155595"),
      LocationModel(id: 4, lat: "9.996341", long: "-84.155359"),
      LocationModel(id: 5, lat: "10.000800", long: "-84.160230"),
      LocationModel(id: 6, lat: "9.998676", long: "-84.157119")
    ];
  }
}