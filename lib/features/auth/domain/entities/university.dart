import 'package:freezed_annotation/freezed_annotation.dart';

part 'university.freezed.dart';

@freezed
class University with _$University {
  const factory University({
    required int id,
    required String name,
    String? region,
    String? logoImageUrl,
  }) = _University;
}
