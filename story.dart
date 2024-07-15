// story.dart
class StoryNode {
  final String text;
  final String animation;
  final List<Choice> choices;

  StoryNode({required this.text, required this.animation, required this.choices});
}

class Choice {
  final String text;
  final String nextNode;

  Choice({required this.text, required this.nextNode});
}

final Map<String, StoryNode> exampleStoryMap = {
  'start': StoryNode(
    text: 'You find yourself in a mysterious forest. What do you do?',
    animation: 'forest.riv',
    choices: [
      Choice(text: 'Explore deeper', nextNode: 'deep_forest'),
      Choice(text: 'Look for a way out', nextNode: 'forest_edge'),
    ],
  ),
  'deep_forest': StoryNode(
    text: 'You discover an ancient ruin. Do you enter?',
    animation: 'ruin.riv',
    choices: [
      Choice(text: 'Enter the ruin', nextNode: 'inside_ruin'),
      Choice(text: 'Continue exploring the forest', nextNode: 'magical_clearing'),
    ],
  ),
  'forest_edge': StoryNode(
    text: 'You reach the edge of the forest and see a town in the distance.',
    animation: 'town.riv',
    choices: [
      Choice(text: 'Head towards the town', nextNode: 'town_entrance'),
      Choice(text: 'Return to the forest', nextNode: 'start'),
    ],
  ),
  // Add more nodes as needed
};
