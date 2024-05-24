import 'package:flutter/material.dart';
import 'package:flutter_reorder_list_view/pages/bookmark_page.dart';
import 'package:flutter_reorder_list_view/pages/list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentIndex;

  List<BottomNavigationBarItem> getPage() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark),
        label: 'Bookmark',
      ),
    ];
  }

  static List<Widget> pageList = [
    const ListPage(),
    const BookMarkPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: getPage(),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: pageList[currentIndex],
    );
  }
}
