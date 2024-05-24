import 'package:logger/logger.dart';
import 'package:flutter_reorder_list_view/model/list_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_item.g.dart';

Logger logger = Logger();

@Riverpod(keepAlive: true)
class ListData extends _$ListData {
  Future<List<ListItem>> build() async {
    logger.i('fetchListItems');
    return init();
  }

  Future<List<ListItem>> init() async {
    logger.i('init');
    return [
      ListItem(id: 1, name: 'りんご', isBookmarked: false),
      ListItem(id: 2, name: 'みかん', isBookmarked: false),
      ListItem(id: 3, name: 'バナナ', isBookmarked: false),
      ListItem(id: 4, name: 'パイナップル', isBookmarked: false),
      ListItem(id: 5, name: 'いちご', isBookmarked: false),
      ListItem(id: 6, name: 'ぶどう', isBookmarked: false),
      ListItem(id: 7, name: 'メロン', isBookmarked: false),
      ListItem(id: 8, name: 'スイカ', isBookmarked: false),
      ListItem(id: 9, name: 'さくらんぼ', isBookmarked: false),
      ListItem(id: 10, name: 'もも', isBookmarked: false),
      ListItem(id: 11, name: 'グレープフルーツ', isBookmarked: false),
      ListItem(id: 12, name: 'キウイ', isBookmarked: false),
      ListItem(id: 13, name: 'パイナップル2', isBookmarked: false),
      ListItem(id: 14, name: 'いちご2', isBookmarked: false),
      ListItem(id: 15, name: 'ぶどう2', isBookmarked: false),
      ListItem(id: 16, name: 'メロン2', isBookmarked: false),
      ListItem(id: 17, name: 'スイカ2', isBookmarked: false),
      ListItem(id: 18, name: 'さくらんぼ2', isBookmarked: false),
      ListItem(id: 19, name: 'もも2', isBookmarked: false),
      ListItem(id: 20, name: 'グレープフルーツ2', isBookmarked: false),
    ];
  }

  //BookmarkのOn/Offを切り替える
  void updateBookmark(int id) {
    logger.i('updateBookmark');
    final item = state.value;
    if (item != null) {
      final index = item.indexWhere((element) => element.id == id);
      item[index] = item[index].copyWith(isBookmarked: !item[index].isBookmarked);
      state = AsyncValue.data(item);
    } else {
      logger.e('state.value is null');
    }
  }
}
