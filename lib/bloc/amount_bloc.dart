import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'amount_event.dart';
part 'amount_state.dart';

class AmountBloc extends Bloc<AmountEvent, AmountState> {
  static const double _conversionFee = 0.0007;
  static const double _rate = 133.64;
  static const double usdToUsdConversionFee = 15;

  AmountBloc() : super(AmountInitial()) {
    on<UpdateSenderAmount>((event, emit) {
      // Calculate recipientGets based on senderAmount
      double afterUsdToNprConversion =
          event.senderAmount * (1 - _conversionFee);
      double nprRecipientGets =
          double.parse((afterUsdToNprConversion * _rate).toStringAsFixed(2));
      emit(AmountUpdated(nprRecipientGets, afterUsdToNprConversion, _rate));
    });
    on<UpdateUsdToUsdSenderAmount>((event, emit) {
      // Calculate recipientGets based on senderAmount
      double usdRecipientGets = double.parse(
          (event.senderUSDAmount - usdToUsdConversionFee).toStringAsFixed(2));
      emit(AmountUSDUpdated(usdRecipientGets, usdToUsdConversionFee));
    });
  }
}
