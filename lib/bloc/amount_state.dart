part of 'amount_bloc.dart';

abstract class AmountState extends Equatable {
  const AmountState();

  @override
  List<Object> get props => [];
}

class AmountInitial extends AmountState {}

class AmountUpdated extends AmountState {
  final double recipientGets;
  final double afterConversion;
  final double rate;

  const AmountUpdated(
    this.recipientGets,
    this.afterConversion,
    this.rate,
  );

  @override
  List<Object> get props => [recipientGets, rate, afterConversion];
}
