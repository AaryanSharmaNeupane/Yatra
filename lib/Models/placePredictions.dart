class PlacePredictions {
  late String secondary_text;
  late String main_text;
  late String place_id;

  PlacePredictions({
    this.secondary_text = "Secondary text",
    this.main_text = "Main text",
    this.place_id = "Place Id",
  });

  PlacePredictions.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
    main_text = json["structured_formatting"]["main_text"];
    secondary_text = json["structured_formatting"]["secondary_text"];
  }
}
