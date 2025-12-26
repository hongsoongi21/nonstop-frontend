import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nonstop/features/timetable/domain/entities/event.dart';

part 'event_dto.freezed.dart';
part 'event_dto.g.dart';

/// DTO for Event entity - handles API serialization/deserialization
@freezed
class EventDto with _$EventDto {
  const factory EventDto({
    required String id,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    required String eventType,
    required String userId,
    String? location,
    int? color,
    @Default(false) bool? isAllDay,
    @Default([]) List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EventDto;

  const EventDto._();

  factory EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);

  /// Convert DTO to domain entity
  Event toDomain() {
    return Event(
      id: id,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      type: _parseEventType(eventType),
      userId: userId,
      location: location,
      color: color,
      isAllDay: isAllDay,
      tags: tags,
      metadata: metadata,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Convert domain entity to DTO
  static EventDto fromDomain(Event event) {
    return EventDto(
      id: event.id,
      title: event.title,
      description: event.description,
      startTime: event.startTime,
      endTime: event.endTime,
      eventType: event.type.name,
      userId: event.userId,
      location: event.location,
      color: event.color,
      isAllDay: event.isAllDay,
      tags: event.tags,
      metadata: event.metadata,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
    );
  }

  /// Parse event type from string
  static EventType _parseEventType(String type) {
    switch (type.toLowerCase()) {
      case 'course':
        return EventType.course;
      case 'exam':
        return EventType.exam;
      case 'assignment':
        return EventType.assignment;
      case 'meeting':
        return EventType.meeting;
      case 'personal':
        return EventType.personal;
      case 'other':
        return EventType.other;
      default:
        return EventType.other;
    }
  }
}

/// DTO for creating a new event
@freezed
class CreateEventDto with _$CreateEventDto {
  const factory CreateEventDto({
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    required String eventType,
    required String userId,
    String? location,
    int? color,
    @Default(false) bool? isAllDay,
    @Default([]) List<String>? tags,
    Map<String, dynamic>? metadata,
  }) = _CreateEventDto;

  const CreateEventDto._();

  factory CreateEventDto.fromJson(Map<String, dynamic> json) => _$CreateEventDtoFromJson(json);

  /// Create from domain entity
  static CreateEventDto fromDomain(Event event) {
    return CreateEventDto(
      title: event.title,
      description: event.description,
      startTime: event.startTime,
      endTime: event.endTime,
      eventType: event.type.name,
      userId: event.userId,
      location: event.location,
      color: event.color,
      isAllDay: event.isAllDay,
      tags: event.tags,
      metadata: event.metadata,
    );
  }
}

/// DTO for updating an event
@freezed
class UpdateEventDto with _$UpdateEventDto {
  const factory UpdateEventDto({
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    required String eventType,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  }) = _UpdateEventDto;

  const UpdateEventDto._();

  factory UpdateEventDto.fromJson(Map<String, dynamic> json) => _$UpdateEventDtoFromJson(json);

  /// Create from domain entity
  static UpdateEventDto fromDomain(Event event) {
    return UpdateEventDto(
      title: event.title,
      description: event.description,
      startTime: event.startTime,
      endTime: event.endTime,
      eventType: event.type.name,
      location: event.location,
      color: event.color,
      isAllDay: event.isAllDay,
      tags: event.tags,
      metadata: event.metadata,
    );
  }
}

/// Response wrapper for API responses
@freezed
class EventResponseDto with _$EventResponseDto {
  const factory EventResponseDto({
    required bool success,
    required EventDto data,
    String? message,
    List<String>? errors,
  }) = _EventResponseDto;

  const EventResponseDto._();

  factory EventResponseDto.fromJson(Map<String, dynamic> json) => _$EventResponseDtoFromJson(json);
}

/// List response wrapper for multiple events
@freezed
class EventListResponseDto with _$EventListResponseDto {
  const factory EventListResponseDto({
    required bool success,
    required List<EventDto> data,
    String? message,
    int? totalCount,
    int? page,
    int? pageSize,
  }) = _EventListResponseDto;

  const EventListResponseDto._();

  factory EventListResponseDto.fromJson(Map<String, dynamic> json) => _$EventListResponseDtoFromJson(json);
}

/// Simple response for operations without data
@freezed
class SimpleResponseDto with _$SimpleResponseDto {
  const factory SimpleResponseDto({
    required bool success,
    String? message,
    List<String>? errors,
  }) = _SimpleResponseDto;

  const SimpleResponseDto._();

  factory SimpleResponseDto.fromJson(Map<String, dynamic> json) => _$SimpleResponseDtoFromJson(json);
}
