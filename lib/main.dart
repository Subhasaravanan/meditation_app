import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MeditationApp());
}

class MeditationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink[300],
        scaffoldBackgroundColor: Colors.pink[50],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink[200],
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/kawai_girl.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimerSelectionScreen()),
                  );
                },
                child: Text(
                  'Start your holistic journey!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerSelectionScreen extends StatefulWidget {
  @override
  _TimerSelectionScreenState createState() => _TimerSelectionScreenState();
}

class _TimerSelectionScreenState extends State<TimerSelectionScreen> {
  int? selectedMinutes;
  final AudioPlayer player = AudioPlayer();
  int meditationStreak = 0; // Add your logic for streak tracking here
  bool isPlaying = false; // Track if audio is playing

  void startMeditation() async {
    if (selectedMinutes != null) {
      await player.setAsset('assets/audio/Nirvana-Shatakam.mp3');
      await player.play();
      setState(() {
        isPlaying = true; // Update play state
        meditationStreak +=
            1; // Increment the streak for each meditation session
      });
    }
  }

  void stopMeditation() async {
    await player.stop();
    setState(() {
      isPlaying = false; // Update play state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Timer')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose timer and start meditating',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('5 minutes'),
            leading: Radio(
              value: 5,
              groupValue: selectedMinutes,
              onChanged: (value) {
                setState(() {
                  selectedMinutes = value as int?;
                });
              },
            ),
          ),
          ListTile(
            title: Text('10 minutes'),
            leading: Radio(
              value: 10,
              groupValue: selectedMinutes,
              onChanged: (value) {
                setState(() {
                  selectedMinutes = value as int?;
                });
              },
            ),
          ),
          ListTile(
            title: Text('15 minutes'),
            leading: Radio(
              value: 15,
              groupValue: selectedMinutes,
              onChanged: (value) {
                setState(() {
                  selectedMinutes = value as int?;
                });
              },
            ),
          ),
          // Add meditating girl image here
          Image.asset(
            'assets/images/kawai(2).jpg', // Add your meditating girl image path
            fit: BoxFit.cover,
            height: 150, // Adjust the height as needed
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: startMeditation,
            child: Text('Start Meditation'),
          ),
          SizedBox(height: 20),
          Text('Meditation Streak: $meditationStreak'),
          SizedBox(height: 20),
          if (isPlaying) // Show stop button only when audio is playing
            ElevatedButton(
              onPressed: stopMeditation,
              child: Text('Stop Meditation'),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExploreMeditationsScreen()),
              );
            },
            child: Text('Explore Meditations'),
          ),
        ],
      ),
    );
  }
}

class ExploreMeditationsScreen extends StatelessWidget {
  final List<Map<String, String>> videos = [
    {
      'title': 'Guided Meditation',
      'thumbnail': 'assets/images/guided_pranayama.png',
      'video': 'assets/videos/guided_pranayama.mp4',
    },
    {
      'title': 'Crown Chakra Activation',
      'thumbnail': 'assets/images/crown_chakra.jpg',
      'video': 'assets/videos/crown_chakra.mp4',
    },
    {
      'title': 'Solfeggio Frequencies',
      'thumbnail': 'assets/images/Solfeggio_Frequencies.jpg',
      'video': 'assets/videos/Solfeggio_Frequencies.mp4',
    },
    {
      'title': 'ASMR Relaxation',
      'thumbnail': 'assets/images/asmr.jpg',
      'video': 'assets/videos/asmr.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore Meditations')),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Add padding to avoid overflow
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8, // Adjust aspect ratio for better card size
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoPlayerScreen(videos[index]['video']!),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Curved corners
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.0)), // Curve the top corners
                      child: Image.asset(
                        videos[index]['thumbnail']!,
                        fit: BoxFit.cover,
                        height: 100, // Set a fixed height for images
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      videos[index]['title']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  VideoPlayerScreen(this.videoPath);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
