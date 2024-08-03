part of 'amount_bloc.dart';

abstract class AmountEvent extends Equatable {
  const AmountEvent();

  @override
  List<Object> get props => [];
}

class UpdateSenderAmount extends AmountEvent {
  final double senderAmount;

  const UpdateSenderAmount(this.senderAmount);

  @override
  List<Object> get props => [senderAmount];
}

class UpdateUsdToUsdSenderAmount extends AmountEvent {
  final double senderUSDAmount;

  const UpdateUsdToUsdSenderAmount(this.senderUSDAmount);

  @override
  List<Object> get props => [senderUSDAmount];
}
