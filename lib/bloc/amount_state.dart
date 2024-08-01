part of 'amount_bloc.dart';

@immutable
sealed class AmountState {}

class AmountInitial extends AmountState {}

class AmountUpdated extends AmountState {
  final double recipientGets;
  AmountUpdated(this.recipientGets);
}
