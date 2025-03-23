import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/services/firestore/users_service.dart';
import 'package:sound_mp3/utils/app_strings.dart';
import 'package:sound_mp3/utils/shared_prefs_helper.dart';
import 'package:sound_mp3/utils/time_format.dart';

class MusicPlayerViewmodel extends ChangeNotifier {
  final UsersService _usersService = UsersService();
  List<Songs> _playlist = [];
  int? _currentIndex;
  bool _isPlaying = false;
  bool _isLiked = false;

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
  bool get isLiked => _isLiked;

  //setter
  set currentIndex(int? newIndex) {
    _currentIndex = newIndex;

    if (newIndex != null) {
      // Gọi getIsLikedSong khi bài hát thay đổi
      getIsLikedSong(_playlist[_currentIndex!].id!);
      play();
    }
    notifyListeners();
  }

  set playlist(List<Songs> newPlaylist) {
    _playlist = newPlaylist;
    notifyListeners();
  }

  set isLiked(bool newValue) {
    _isLiked = newValue;
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

    // lay uid tu Shared Prefs và add vao song history
    String uid = await SharedPrefsHelper.getUserId(AppStrings.uid);
    await _usersService.addSongHistory(
        uid, formatDateYMD(DateTime.now()), _playlist[_currentIndex!].id!);
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
  void playNextSong() async {
    if (_currentIndex != null) {
      if (_currentIndex! < _playlist.length - 1) {
        _currentIndex = _currentIndex! + 1;
      } else {
        _currentIndex = 0;
      }
      // Gọi getIsLikedSong khi bài hát thay đổi
      await getIsLikedSong(_playlist[_currentIndex!].id!);
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
      await getIsLikedSong(_playlist[_currentIndex!].id!);
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

  Future<void> getIsLikedSong(String songId) async {
    try {
      String userId = await SharedPrefsHelper.getUserId(AppStrings.uid);
      _isLiked = await _usersService.isSongLiked(userId, songId);
    } catch (error) {
      print("err in viewmodel");
    } finally {
      notifyListeners();
    }
  }
}
