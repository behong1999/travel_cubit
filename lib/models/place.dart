class Place {
  String name;
  String img;
  double price;
  int people;
  int stars;
  String description;
  String location;
  String type;

  Place({
    required this.name,
    required this.img,
    required this.price,
    required this.people,
    required this.stars,
    required this.description,
    required this.location,
    required this.type,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        name: json["name"],
        img: json["img"],
        price: json["price"],
        people: json["people"],
        stars: json["stars"],
        description: json["description"],
        location: json["location"],
        type: json["type"]);
  }
}
