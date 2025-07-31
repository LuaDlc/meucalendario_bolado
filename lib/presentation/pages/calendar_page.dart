import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meucalendario_bolado/domain/entities/event.dart';
import 'package:meucalendario_bolado/presentation/bloc/event_bloc/event_event.dart';

import '../bloc/event_bloc/event_bloc.dart';
import '../bloc/event_bloc/event_state.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu calendario bolado')),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventLoaded) {
            if (state.events.isEmpty) {
              return const Center(child: Text('Nenhum evento encontrado'));
            }
            return ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(
                    '${event.date.toLocal().toIso8601String().split('T')[0]} '
                    '${event.startTime.hour.toString().padLeft(2, '0')}:${event.startTime.minute.toString().padLeft(2, '0')} - '
                    '${event.endTime.hour.toString().padLeft(2, '0')}:${event.endTime.minute.toString().padLeft(2, '0')}',
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<EventBloc>().add(DeleteEvent(event.id));
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap: () {
                    //implementar  a navegacao para a tela de detalhes do evento e de edição
                  },
                );
              },
            );
          } else if (state is EventError) {
            return Center(child: Text('Erro ${state.message}'));
          }
          return const Center(child: Text('Estado inicial do calendario'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //exemplo de um evento de teste
          final newEvent = Event(
            id: '1',
            title: 'evento de teste',
            date: DateTime.now(),
            startTime: DateTime.now().copyWith(
              hour: 9,
              minute: 0,
              second: 0,
              millisecond: 0,
              microsecond: 0,
            ),
            endTime: DateTime.now().copyWith(
              hour: 10,
              minute: 0,
              second: 0,
              millisecond: 0,
              microsecond: 0,
            ),
          );
          context.read<EventBloc>().add(AddEvent(newEvent));
        },
      ),
    );
  }
}
