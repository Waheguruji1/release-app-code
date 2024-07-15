import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'story_page.dart';
import 'story.dart';
void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Selection'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: List.generate(8, (index) {
          return ElevatedButton(
            child: Text('Story ${index + 1}'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryPage(
                    storyMap: storyMaps[index],
                    onNodeChange: () {
                      // Add ad logic here if needed
                    },
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
