import 'package:logger/logger.dart';
import 'package:flutter_reorder_list_view/model/list_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark.g.dart';

Logger logger = Logger();

@Riverpod(keepAlive: true)
class Bookmark extends _$Bookmark {
  Future<List<ListItem>> build() async {
    return [];
  }

  void toggleBookmark(ListItem item, bool isBookmarked) {
    logger.i('toggleBookmark');
    if (isBookmarked) {
      add(item);
    } else {
      remove(item);
    }
  }

  //Bookmarkの追加
  void add(ListItem item) {
    logger.i('add');
    final items = state.value;
    if (items != null) {
      items.add(item);
      state = AsyncValue.data(items);
    } else {
      state = AsyncValue.data([item]);
    }
  }

  //Bookmarkの削除
  void remove(ListItem item) {
    logger.i('remove');
    final items = state.value;
    if (items != null) {
      items.removeWhere((element) => element.id == item.id);
      state = AsyncValue.data(items);
    } else {
      logger.e('state.value is null');
    }
  }

  //Bookmarkの並び替え
  void indexReorder(int oldIndex, int newIndex) {
    logger.i('indexReorder');
    final items = state.value;
    final item = items!.removeAt(oldIndex); //消して(removeAtは消した値を返す)
    items.insert(newIndex, item); //入れる
    state = AsyncValue.data(items);
  }
}
