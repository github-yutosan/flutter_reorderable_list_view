import 'package:flutter/material.dart';
import 'package:flutter_reorder_list_view/provider/bookmark.dart';
import 'package:flutter_reorder_list_view/provider/list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookMarkPage extends ConsumerWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmark = ref.watch(bookmarkProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ブックマーク画面'),
      ),
      body: Column(
        children: [
          Expanded(
            child: bookmark.when(
              data: (data) {
                return ReorderableListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(data[index].name),
                      onDismissed: (direction) {
                        final name = data[index].name;
                        ref.read(listDataProvider.notifier).updateBookmark(data[index].id); //先にBookmarkの状態を変更
                        ref.read(bookmarkProvider.notifier).remove(data[index]); //Bookmarkから削除
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${name}をブックマークから削除しました'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete),
                      ),
                      child: ListTile(
                        key: ValueKey(data[index].name),
                        title: Text(data[index].name),
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    ref.read(bookmarkProvider.notifier).indexReorder(oldIndex, newIndex);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
