import 'package:equatable/equatable.dart';

class SendMoney extends Equatable {
  final int amount;
  final String? ref;
  final String name;
  final String number;

  const SendMoney(
      {required this.amount,
      this.ref,
      required this.name,
      required this.number});

  ///CopyWith
  SendMoney copyWith({
    int? amount,
    String? ref,
    String? name,
    String? number,
  }) {
    return SendMoney(
        amount: amount ?? this.amount,
        name: name ?? this.name,
        number: number ?? this.number,
        ref: ref ?? this.ref);
  }

  @override
  List<Object?> get props => [amount, name, number, ref];
}
