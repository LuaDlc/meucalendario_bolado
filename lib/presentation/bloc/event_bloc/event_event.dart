import 'package:equatable/equatable.dart';

import '../../../domain/entities/event.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvents extends EventEvent {
  final DateTime? date;
  const LoadEvents({this.date});
  @override
  List<Object?> get props => [date];
}

class AddEvent extends EventEvent {
  final Event event;
  const AddEvent(this.event);

  @override
  List<Object?> get props => [event];
}

class UpdateEvent extends EventEvent {
  final Event event;
  const UpdateEvent(this.event);

  @override
  List<Object?> get props => [event];
}

class DeleteEvent extends EventEvent {
  final String eventId;
  const DeleteEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}
