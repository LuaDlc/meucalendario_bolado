import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meucalendario_bolado/presentation/bloc/event_bloc/event_bloc.dart';

import 'app.dart';
import 'data/repositories/event_repository_imp.dart';
import 'presentation/bloc/event_bloc/event_event.dart';

void main() {
  runApp(
    RepositoryProvider(
      create:
          (context) =>
              EventRepositoryImp(), //fornecendo a implementacao do repositorio
      child: BlocProvider<EventBloc>(
        create:
            (context) => EventBloc(
              eventRepository: RepositoryProvider.of<EventRepositoryImp>(
                context,
              ),
            )..add(LoadEvents()),
        child: const MyApp(),
      ),
    ),
  );
}
