import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'amount_event.dart';
part 'amount_state.dart';

class AmountBloc extends Bloc<AmountEvent, AmountState> {
  AmountBloc() : super(AmountInitial()) {
    log('AmountBloc initialized');
    on<UpdateSenderAmount>((event, emit) {
      log('Received amount: ${event.amount}');
      double recipientGets = event.amount * 134;
      log('Calculated recipient gets: $recipientGets');
      emit(AmountUpdated(recipientGets));
    });
  }
}
