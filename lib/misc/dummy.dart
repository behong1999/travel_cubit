class Dummy {
  static const List<Map<String, dynamic>> locations = [
    {
      "image": "OnLangTemple.jpg",
      "name": "On Lang Temple",
      "location": "Saigon, Vietnam",
      "description":
          "Chinese-style Buddhist pagoda founded in the 19th century and located in Vietnam",
      "price": 15,
      "stars": 5,
      "people": 3,
      "type": "pagoda"
    },
    {
      "image": "NotreDome.jpg",
      "name": "Notre Dame Cathedral of Saigon",
      "location": "Saigon, Vietnam",
      "description":
          "Established by French colonists who initially named it the Church of Saigon, the cathedral was constructed between 1863 and 1880.",
      "price": 15,
      "stars": 4,
      "people": 2,
    },
    {
      "image": "ReunificationPalace.jpg",
      "name": "Independence Palace",
      "location": "Saigon, Vietnam",
      "description":
          "Designed by architect Ngô Viết Thụ and was the home and workplace of the President of Republic of Vietnam.",
      "price": 20,
      "stars": 5,
      "people": 2,
    }
  ];

  static const icons = {
    "ballooning.png": "Ballooning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkeling.png": "Snorkeling",
  };

  static const List buildingTypes = ["Pagoda", "Church", "Historical"];
}
