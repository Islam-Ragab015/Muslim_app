import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance
  int? _selectedStationIndex;
  bool _isPlaying = false;

  // List of radio stations with real URLs
  final List<Map<String, String>> _radioStations = [
    {"name": "إذاعة القرآن الكريم", "url": "https://qurango.net/radio/mix"},
    {"name": "إذاعة السنة النبوية", "url": "http://live.mp3quran.net:8006/"},
    {"name": "إذاعة الحديث الشريف", "url": "http://mp3quran.net:8004"},
  ];

  // Play selected station
  Future<void> _playRadio(int index) async {
    final stationUrl = _radioStations[index]['url']!;
    try {
      await _audioPlayer.play(UrlSource(stationUrl));
      setState(() {
        _selectedStationIndex = index;
        _isPlaying = true;
      });
    } catch (e) {
      _showErrorDialog("تعذر تشغيل المحطة. تحقق من اتصال الإنترنت.");
    }
  }

  // Stop the currently playing radio
  Future<void> _stopRadio() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      _showErrorDialog("تعذر إيقاف المحطة. حاول مرة أخرى.");
    }
  }

  // Show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("خطأ"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("حسناً"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Release resources when the screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("راديو إسلامي"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Column(
              children: [
                if (_selectedStationIndex != null)
                  Text(
                    "تشغيل الآن: ${_radioStations[_selectedStationIndex!]['name']}",
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                else
                  const Text("اختر محطة تشغيل", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isPlaying ? _stopRadio : null,
                      icon: const Icon(Icons.stop),
                      label: const Text("إيقاف"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: !_isPlaying && _selectedStationIndex != null
                          ? () => _playRadio(_selectedStationIndex!)
                          : null,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("تشغيل"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _radioStations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.radio, color: Colors.blueAccent),
                  title: Text(_radioStations[index]['name']!),
                  selected: _selectedStationIndex == index,
                  selectedTileColor: Colors.blue[50],
                  onTap: () {
                    setState(() {
                      _selectedStationIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
