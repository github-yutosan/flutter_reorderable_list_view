import 'package:flutter/material.dart';
import 'package:flutter_reorder_list_view/provider/bookmark.dart';
import 'package:flutter_reorder_list_view/provider/list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listData = ref.watch(listDataProvider);
    ref.watch(bookmarkProvider); //初期化用に呼び出し(build)

    return Scaffold(
      appBar: AppBar(
        title: const Text('一覧画面'),
      ),
      body: listData.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: GestureDetector(
                        child: Icon(data[index].isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                        onTap: () {
                          ref.read(listDataProvider.notifier).updateBookmark(data[index].id);
                          ref.read(bookmarkProvider.notifier).toggleBookmark(data[index], data[index].isBookmarked);
                        },
                      ),
                      title: Text(data[index].name),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
