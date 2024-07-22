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

final Map<String, Map<String, StoryNode>> storyMaps = {
  'Forest Adventure': {
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
    'inside_ruin': StoryNode(
      text: 'Inside the ruin, you find a magical artifact. What do you do?',
      animation: 'artifact.riv',
      choices: [
        Choice(text: 'Take the artifact', nextNode: 'artifact_taken'),
        Choice(text: 'Leave it alone', nextNode: 'leave_ruin'),
      ],
    ),
    'magical_clearing': StoryNode(
      text: 'You stumble upon a magical clearing with fairy creatures.',
      animation: 'fairy.riv',
      choices: [
        Choice(text: 'Approach the fairies', nextNode: 'fairy_interaction'),
        Choice(text: 'Quietly leave', nextNode: 'forest_edge'),
      ],
    ),
  },
  
  'Space Odyssey': {
    'start': StoryNode(
      text: 'You wake up on a spaceship with no memory. What\'s your first move?',
      animation: 'spaceship_interior.riv',
      choices: [
        Choice(text: 'Check the ship\'s computer', nextNode: 'computer_room'),
        Choice(text: 'Look out the window', nextNode: 'space_view'),
      ],
    ),
    'computer_room': StoryNode(
      text: 'The computer shows a distress signal from a nearby planet. What do you do?',
      animation: 'computer_screen.riv',
      choices: [
        Choice(text: 'Investigate the signal', nextNode: 'planet_approach'),
        Choice(text: 'Ignore it and try to return home', nextNode: 'space_journey'),
      ],
    ),
    'space_view': StoryNode(
      text: 'You see a strange alien ship approaching. How do you respond?',
      animation: 'alien_ship.riv',
      choices: [
        Choice(text: 'Try to communicate', nextNode: 'alien_contact'),
        Choice(text: 'Prepare for potential conflict', nextNode: 'ship_battle'),
      ],
    ),
    'planet_approach': StoryNode(
      text: 'As you approach the planet, your ship starts malfunctioning. What\'s your plan?',
      animation: 'planet_view.riv',
      choices: [
        Choice(text: 'Attempt emergency landing', nextNode: 'crash_landing'),
        Choice(text: 'Try to fix the ship mid-flight', nextNode: 'space_repair'),
      ],
    ),
  },
  
  'Detective Mystery': {
    'start': StoryNode(
      text: 'A wealthy businessman has been murdered. Where do you begin your investigation?',
      animation: 'crime_scene.riv',
      choices: [
        Choice(text: 'Examine the body', nextNode: 'body_examination'),
        Choice(text: 'Interview the family', nextNode: 'family_interview'),
      ],
    ),
    'body_examination': StoryNode(
      text: 'You find unusual marks on the victim\'s neck. What\'s your next step?',
      animation: 'forensic_closeup.riv',
      choices: [
        Choice(text: 'Analyze the marks in the lab', nextNode: 'lab_analysis'),
        Choice(text: 'Look for similar cases in the database', nextNode: 'database_search'),
      ],
    ),
    'family_interview': StoryNode(
      text: 'The victim\'s wife seems nervous. Do you press her for more information?',
      animation: 'interview_room.riv',
      choices: [
        Choice(text: 'Press for more details', nextNode: 'wife_confession'),
        Choice(text: 'Thank her and investigate elsewhere', nextNode: 'office_search'),
      ],
    ),
    'lab_analysis': StoryNode(
      text: 'The lab results show traces of a rare poison. What\'s your theory?',
      animation: 'lab_results.riv',
      choices: [
        Choice(text: 'Professional hit', nextNode: 'hitman_lead'),
        Choice(text: 'Personal vendetta', nextNode: 'rival_investigation'),
      ],
    ),
  },
};
