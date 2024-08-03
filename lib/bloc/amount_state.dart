part of 'amount_bloc.dart';

abstract class AmountState extends Equatable {
  const AmountState();

  @override
  List<Object> get props => [];
}

class AmountInitial extends AmountState {}

class AmountUpdated extends AmountState {
  final double nprRecipientGets;
  final double afterUsdToNprConversion;
  final double rate;

  const AmountUpdated(
    this.nprRecipientGets,
    this.afterUsdToNprConversion,
    this.rate,
  );

  @override
  List<Object> get props => [nprRecipientGets, rate, afterUsdToNprConversion];
}
