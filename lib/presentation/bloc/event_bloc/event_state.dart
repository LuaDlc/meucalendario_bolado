import 'package:equatable/equatable.dart';
import 'package:meucalendario_bolado/domain/entities/event.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object?> get props => [];
}

class EventInitital extends EventState {
  const EventInitital();
}

class EventLoading extends EventState {
  const EventLoading();
}

class EventLoaded extends EventState {
  final List<Event> events;

  const EventLoaded({this.events = const []});

  @override
  List<Object?> get props => [events];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object?> get props => [message];
}
