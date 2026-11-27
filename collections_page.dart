import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  int currentIndex = 0;
  final controller = PageController(viewportFraction: 0.75);
  List<dynamic> items = [];

  // Читаем локальный файл и обновляем интерфейс.
  Future<void> loadData() async {
    final data = await rootBundle.loadString('assets/data/collections.json');
    if (!mounted) return;
    setState(() {
      items = jsonDecode(data);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      color: Color(0xFF101C18),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Not to be missed',
              style: TextStyle(color: Colors.white, fontSize: 30)),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: items.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: index == currentIndex ? 1.0 : 0.4,
                  child: AnimatedScale(
                    duration: Duration(milliseconds: 300),
                    scale: index == currentIndex ? 1.0 : 0.7,
                    child: Image.asset(items[index]['image'], fit: BoxFit.contain),
                  ),
                );
              },
            ),
          ),
          Text(items[currentIndex]['title'],
              style: TextStyle(color: Colors.white, fontSize: 25)),
          SizedBox(height: 10),
          Text(items[currentIndex]['description'],
              style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white),
            ),
            child: Text('Learn more'),
          ),
        ],
      ),
    );
  }
}
