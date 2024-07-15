// user_onboarding.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserOnboardingPage extends StatefulWidget {
  @override
  _UserOnboardingPageState createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  final TextEditingController _nameController = TextEditingController();

  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameController.text);
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveName,
              child: Text('Start Adventure'),
            ),
          ],
        ),
      ),
    );
  }
}
