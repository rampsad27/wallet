part of 'amount_bloc.dart';

abstract class AmountEvent {}

class UpdateSenderAmount extends AmountEvent {
  final double amount;
  UpdateSenderAmount(this.amount);
}
