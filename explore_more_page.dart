import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExploreMorePage extends StatefulWidget {
  const ExploreMorePage({super.key});

  @override
  State<ExploreMorePage> createState() => _ExploreMorePageState();
}

class _ExploreMorePageState extends State<ExploreMorePage> {
  List<dynamic> items = [];
  final controller = ScrollController();

  Future<void> loadData() async {
    final data = await rootBundle.loadString('assets/data/explore_more.json');
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
    return Container(
      color: Color(0xFF101C18),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Explore More',
              style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(height: 20),
          Expanded(
            child: Scrollbar(
              controller: controller,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 4,
              child: GridView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 180,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(items[index]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[index]['title'],
                            style: TextStyle(color: Colors.white, fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text(items[index]['description'],
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
