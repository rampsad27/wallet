import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'amount_event.dart';
part 'amount_state.dart';

class AmountBloc extends Bloc<AmountEvent, AmountState> {
  static const double _conversionFee = 0.0007;
  static const double _rate = 133.64;

  AmountBloc() : super(AmountInitial()) {
    on<UpdateSenderAmount>((event, emit) {
      // Calculate recipientGets based on senderAmount
      double afterConversion = event.senderAmount * (1 - _conversionFee);
      double recipientGets =
          double.parse((afterConversion * _rate).toStringAsFixed(2));
      emit(AmountUpdated(recipientGets, afterConversion, _rate));
    });
  }
}
