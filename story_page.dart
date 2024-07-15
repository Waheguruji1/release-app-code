import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'story.dart';
import 'rating_dialog.dart';

const String interstitialAdUnitId = 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';

final currentStoryNodeProvider = StateProvider<String>((ref) => 'start');

class StoryPage extends ConsumerStatefulWidget {
  final Map<String, StoryNode> storyMap;
  final VoidCallback onExit;

  const StoryPage({Key? key, required this.storyMap, required this.onExit}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<StoryPage> {
  late AudioPlayer _audioPlayer;
  InterstitialAd? _interstitialAd;
  int _nodeChanges = 0;
  final double _volume = 0.3;
  int _interstitialLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;

  @override
  void initState() {
    super.initState();
    _initAudio();
    _initAdMob();
  }

  Future<void> _initAudio() async {
    _audioPlayer = AudioPlayer();
    try {
      await _audioPlayer.setAsset('assets/background_music.mp3');
      await _audioPlayer.setLoopMode(LoopMode.all);
      await _audioPlayer.setVolume(_volume);
      await _audioPlayer.play();
    } catch (_) {
      // Silently handle any audio initialization errors
    }
  }

  Future<void> _initAdMob() async {
    await _requestConsent();
    await _createInterstitialAd();
  }

  Future<void> _requestConsent() async {
    ConsentRequestParameters params = ConsentRequestParameters();
    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          _loadForm();
        }
      },
      (FormError error) {
        // Handle consent info request error
      },
    );
  }

  void _loadForm() {
    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        if (status == ConsentStatus.required) {
          consentForm.show(
            (FormError? formError) {
              // Handle form show error
            },
          );
        }
      },
      (FormError formError) {
        // Handle form load error
      },
    );
  }

  Future<void> _createInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts++;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show().catchError((_) {
        // Silently handle any errors showing the ad
      });
      _interstitialAd = null;
    }
  }

  Future<void> _showRatingDialog() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userName = prefs.getString('user_name') ?? 'Adventurer';
      showDialog(
        context: context,
        builder: (context) => RatingDialog(
          userName: userName,
          appPackageName: 'com.yourcompany.yourapp', // Replace with your app's package name
        ),
      );
    } catch (_) {
      // Silently handle any errors showing the rating dialog
    }
  }

  void _onNodeChange() {
    _nodeChanges++;
    if (_nodeChanges % 5 == 0) {
      _showInterstitialAd();
      _showRatingDialog();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentNode = ref.watch(currentStoryNodeProvider);
    final storyNode = widget.storyMap[currentNode] ?? widget.storyMap['start']!;

    return WillPopScope(
      onWillPop: () async {
        widget.onExit();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Story'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.onExit,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu'),
              ),
              ListTile(
                title: Text('Main Menu'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  widget.onExit(); // Exit to main menu
                },
              ),
              // Add more drawer items as needed
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    storyNode.text,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: RiveAnimation.asset(
                  'assets/${storyNode.animation}',
                  fit: BoxFit.contain,
                  onError: (_) {
                    // Silently handle Rive animation load errors
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: storyNode.choices.map((choice) => 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(choice.text),
                        onPressed: () {
                          ref.read(currentStoryNodeProvider.notifier).state = choice.nextNode;
                          _onNodeChange();
                        },
                      ),
                    )
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
