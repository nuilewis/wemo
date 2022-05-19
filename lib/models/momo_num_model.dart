import '../enums/wemo_enums.dart';

class MomoNumber {
  final String number;
  final String name;
  final NetworkType network;

  MomoNumber({required this.number, required this.name, required this.network});

  ///Assigning variables values to the map in their corresponding map keys
  MomoNumber.fromMap(Map map)
      : number = map["number"],
        name = map["name"],
        network = map["network"];

  ///Converting from MomoNumber object to a map
  Map toMap() {
    return {"number": number, "name": name, "network": network};
  }
}
