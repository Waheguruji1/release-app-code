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
                    onExit: () {
                      Navigator.pop(context);
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
