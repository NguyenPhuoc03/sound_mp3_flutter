import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:sound_mp3/data/models/songs.dart';

class MusicPlayerViewmodel extends ChangeNotifier {
  List<Songs> _playlist = [];
  int? _currentIndex;
  bool _isPlaying = false;
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // getter
  List<Songs> get playlist => _playlist;
  int? get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //setter
  set currentIndex(int? newIndex) {
    _currentIndex = newIndex;

    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }

  set playlist(List<Songs> newPlaylist) {
    _playlist = newPlaylist;
    notifyListeners();
  }

  // constructor
  MusicPlayerViewmodel() {
    listenToDuration();
  }

  // play the song
  void play() async {
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.stop(); // stop current song
    }
    String source = _playlist[_currentIndex!].source;
    await _audioPlayer.setSourceUrl(source);
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentIndex != null) {
      if (_currentIndex! < _playlist.length - 1) {
        _currentIndex = _currentIndex! + 1;
      } else {
        _currentIndex = 0;
      }
      play();
    }
    notifyListeners();
  }

  //play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentIndex! > 0) {
        _currentIndex = _currentIndex! - 1;
      } else {
        _currentIndex = _playlist.length - 1;
      }
      play();
    }
  }

  // listen to duration
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void stop() async {
    await _audioPlayer.stop();
    _currentIndex = null;
    _isPlaying = false;
    _currentDuration = Duration.zero;
    _totalDuration = Duration.zero;
    notifyListeners();
  }
}
