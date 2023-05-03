part of 'tour_bloc.dart';

@immutable
abstract class TourState {}

class TourInitial extends TourState {}

class TourValueChangedState extends TourState {
  final snapshot;
  TourValueChangedState({
    required this.snapshot,
  });
}
