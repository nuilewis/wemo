import 'package:equatable/equatable.dart';

class MomoNumber extends Equatable {
  final String number;
  final String name;
//  final NetworkType network;
  final String network;

  const MomoNumber({
    required this.number,
    required this.name,
    required this.network,
  });

  ///Assigning variables values to the map in their corresponding map keys
  MomoNumber.fromMap(Map map)
      : number = map["number"],
        name = map["name"],
        network = map["network"];

  ///Converting from MomoNumber object to a map
  Map toMap() {
    return {"number": number, "name": name, "network": network};
  }

  ///CopyWith

  MomoNumber copyWith({
    String? name,
    String? number,
    String? network,
  }) {
    return MomoNumber(
        number: number ?? this.number,
        name: name ?? this.name,
        network: network ?? this.network);
  }

  @override
  List<Object> get props => [name, number, network];
}
