import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final snapshot = null;
  TourBloc() : super(TourInitial()) {
    on<TourEvent>((event, emit) {
      if(event is GetDataFromBase)
      {
        final snapshot = FirebaseFirestore.instance.collection("Areas").snapshots();
      }
    });
  }
}
 