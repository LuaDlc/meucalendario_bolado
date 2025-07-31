import 'package:meucalendario_bolado/domain/entities/event.dart';

import '../../domain/repositories/event_repository.dart';

class EventRepositoryImp implements EventRepository {
  //simulacao de dados em memoria
  final List<Event> _events = [];

  @override
  Future<List<Event>> getEvents({DateTime? date}) async {
    await Future.delayed(Duration(seconds: 1)); // Simula uma chamada assíncrona
    if (date == null) {
      return List.from(_events);
    } else {
      return _events
          .where(
            (e) =>
                e.date.year == date.year &&
                e.date.month == date.month &&
                e.date.day == date.day,
          )
          .toList();
    }
  }

  @override
  Future<void> addEvent(Event event) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _events.add(event);
  }

  @override
  Future<void> deleteEvent(String event) async {
    await Future.delayed(const Duration(milliseconds: 300));

    _events.removeWhere((e) => e.id == event);
  }

  @override
  Future<void> updateEvent(Event event) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _events.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _events[index] = event;
    } else {
      throw Exception('Event not found');
    }
  }
}
