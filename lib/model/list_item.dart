import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item.freezed.dart';
part 'list_item.g.dart';

@freezed
abstract class ListItem with _$ListItem {
  const factory ListItem({
    required int id,
    required String name,
    @Default(false) bool isBookmarked,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);
}
