class MomoNumberSP {
  final String number;
  final String name;
  final String network;

  MomoNumberSP(
      {required this.number, required this.name, required this.network});

  ///Assigning variables values to the map in their corresponding map keys
  MomoNumberSP.fromMap(Map map)
      : number = map["number"],
        name = map["name"],
        network = map["network"];

  ///Converting from MomoNumber object to a map
  Map toMap() {
    return {"number": number, "name": name, "network": network};
  }
}
