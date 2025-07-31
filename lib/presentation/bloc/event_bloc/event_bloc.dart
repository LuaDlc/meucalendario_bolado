import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/event_repository.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc({required this.eventRepository}) : super(EventInitital()) {
    on<LoadEvents>(_onLoadEvents);
    on<AddEvent>(_onAddEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }

  Future<void> _onLoadEvents(LoadEvents event, Emitter<EventState> emit) async {
    emit(EventLoaded());
    try {
      final events = await eventRepository.getEvents(date: event.date);
      emit(EventLoaded(events: events));
    } catch (e) {
      emit(EventError(e.toString()));
    }
  }

  Future<void> _onAddEvent(event, emit) async {
    try {
      await eventRepository.addEvent(event.event);
      emit(EventLoading());
      //apos adicionar recarrega os eventos para atualizar a ui
      final events = await eventRepository.getEvents(date: event.event.date);
      emit(EventLoaded(events: events));
      // add(LoadEvents(date: event.event.date));
    } catch (e) {
      emit(EventError(e.toString()));
    }
  }

  Future<void> _onUpdateEvent(
    UpdateEvent event,
    Emitter<EventState> emit,
  ) async {
    try {
      await eventRepository.updateEvent(event.event);
      add(LoadEvents(date: event.event.date));
    } catch (e) {
      emit(EventError(e.toString()));
    }
  }

  Future<void> _onDeleteEvent(
    DeleteEvent event,
    Emitter<EventState> emit,
  ) async {
    try {
      await eventRepository.deleteEvent(event.eventId);
      add(LoadEvents());
    } catch (e) {
      emit(EventError(e.toString()));
    }
  }
}
