import '../entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents({DateTime? date});
  Future<void> addEvent(Event event);
  Future<void> updateEvent(Event event);
  Future<void> deleteEvent(String eventId);
}
