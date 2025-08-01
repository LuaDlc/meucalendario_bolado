import 'package:meucalendario_bolado/domain/entities/event.dart';
import 'package:meucalendario_bolado/domain/repositories/event_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:meucalendario_bolado/presentation/bloc/event_bloc/event_bloc.dart';
import 'package:meucalendario_bolado/presentation/bloc/event_bloc/event_event.dart';
import 'package:meucalendario_bolado/presentation/bloc/event_bloc/event_state.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  late MockEventRepository mockEventRepository;
  late EventBloc eventBloc;

  setUp(() {
    mockEventRepository = MockEventRepository();
    eventBloc = EventBloc(eventRepository: mockEventRepository);
  });

  tearDown(() {
    eventBloc.close();
  });

  final tEvent = Event(
    id: '1',
    title: 'Test Event',
    startTime: DateTime(2023, 10, 1, 10, 0),
    endTime: DateTime(2023, 10, 1, 12),
    date: DateTime(2023, 10, 1),
  );

  group('EventBloc', () {
    blocTest<EventBloc, EventState>(
      'emits [EventLoading, GetError] when LoadEvents fails',
      build: () {
        when(
          () => mockEventRepository.getEvents(date: any(named: 'date')),
        ).thenThrow(Exception('Failed to load events'));
        return eventBloc;
      },
      act: (bloc) => bloc.add(LoadEvents()),
      expect:
          () => <EventState>[
            EventLoaded(),
            const EventError('Exception: Failed to load events'),
          ],
    );

    blocTest<EventBloc, EventState>(
      'emits [EventLoading, EventLoaded] when LoadEvents is added and successful',
      build: () {
        when(
          () => mockEventRepository.getEvents(date: any(named: 'date')),
        ).thenAnswer((_) async => [tEvent]);
        return eventBloc;
      },
      act: (bloc) => bloc.add(LoadEvents()),
      expect:
          () => <EventState>[
            EventLoaded(),
            EventLoaded(events: [tEvent]),
          ],
    );

    blocTest<EventBloc, EventState>(
      'calls addEvent on repository and reloads when AddEvent is added',
      build: () {
        when(
          () => mockEventRepository.addEvent(tEvent),
        ).thenAnswer((_) async => Future.value());
        when(
          () => mockEventRepository.getEvents(date: any(named: 'date')),
        ).thenAnswer((_) async => [tEvent]);
        return eventBloc;
      },
      act: (bloc) => bloc.add(AddEvent(tEvent)),
      verify: (_) {
        verify(() => mockEventRepository.addEvent(tEvent)).called(1);
        verify(
          () => mockEventRepository.getEvents(date: any(named: 'date')),
        ).called(1);
      },
    );
  });
}
