// main_page.dart

import 'package:flutter/material.dart';
import 'package:myapp/story_page.dart';
import 'story.dart';

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
        children: storyMaps.keys.map((storyTitle) {
          return ElevatedButton(
            child: Text(storyTitle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryPage(
                    storyMap: storyMaps[storyTitle]!,
                    onExit: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
