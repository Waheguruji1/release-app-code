// rating_dialog.dart
import 'package:flutter/material.dart';
import 'package:emoji_rating_bar/emoji_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingDialog extends StatefulWidget {
  final String userName;
  final String appPackageName;

  RatingDialog({required this.userName, required this.appPackageName});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 0;

  Future<void> _launchPlayStore() async {
    final url = 'https://play.google.com/store/apps/details?id=${widget.appPackageName}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate Your Experience'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hey ${widget.userName}, how was your story?'),
          SizedBox(height: 20),
          EmojiRatingBar(
            onRatingChanged: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _rating > 0 ? () {
            _launchPlayStore();
            Navigator.pop(context);
          } : null,
          child: Text('Submit Rating'),
        ),
      ],
    );
  }
}
