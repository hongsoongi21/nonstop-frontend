import 'package:freezed_annotation/freezed_annotation.dart';

part 'policy.freezed.dart';

@freezed
class Policy with _$Policy {
  const factory Policy({
    required int id,
    required String type,
    required String title,
    required String url,
    required bool isMandatory,
  }) = _Policy;
}
