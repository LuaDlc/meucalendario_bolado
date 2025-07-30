// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String? location;
  final List<String> participants;
  final List<Duration> reminders;

  const Event({
    required this.id,
    required this.title,
    this.description = '',
    required this.date,
    required this.startTime,
    required this.endTime,
    this.location,
    this.participants = const [],
    this.reminders = const [],
  });

  List<Object?> get props => [
    id,
    title,
    description,
    date,
    startTime,
    endTime,
    location,
    participants,
    reminders,
  ];

  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    List<String>? participants,
    List<Duration>? reminders,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      participants: participants ?? this.participants,
      reminders: reminders ?? this.reminders,
    );
  }
}
