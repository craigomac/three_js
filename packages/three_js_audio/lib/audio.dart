import 'dart:async';
import 'package:three_js_core/three_js_core.dart';

/// This utility class holds static references to some global audio objects.
///
/// You can use as a helper to very simply play a sound or a background music.
/// Alternatively you can create your own instances and control them yourself.
class Audio extends Object3D {
  bool autoplay;
  bool loop;
  bool hasPlaybackControl;
  bool _isPlaying = false;

  int loopEnd = 0;
  int loopStart = 0;
  //double? duration;
  double playbackRate;

  late double _volume;
  late double _balance;

  Timer? _delay;
  bool get isPlaying => _isPlaying;

  String path;

  Audio(
      {required this.path,
      double balance = 0.0,
      double volume = 1.0,
      this.playbackRate = 1.0,
      this.hasPlaybackControl = true,
      this.autoplay = false,
      this.loop = false}) {
    _balance = balance;
    _volume = volume;

    if (autoplay) {
      play();
    }
  }

  // void setBuffer(Uint8List buffer){
  //   _buffer = buffer;
  // }

  @override
  void dispose() {
    _delay?.cancel();
    super.dispose();
  }

  /// Plays a single run of the given [file], with a given [volume].
  Future<void> play([int delay = 0]) async {
    if (_isPlaying) {
      console.warning('Audio: Audio is already playing.');
      return;
    }

    if (!hasPlaybackControl) {
      console.warning('Audio: this Audio has no playback control.');
      return;
    }

    _isPlaying = true;
  }

  /// Plays a single run of the given [file], with a given [volume].
  Future<void> _play() async {}

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    if (!hasPlaybackControl) {
      console.warning('Audio: this Audio has no playback control.');
      return;
    }

    _delay?.cancel();
    _delay = null;
    _isPlaying = false;
  }

  /// Resumes the currently played (but resumed) background music.
  Future<void> resume() async {
    _isPlaying = true;
  }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    if (!hasPlaybackControl) {
      console.warning('Audio: this Audio has no playback control.');
      return;
    }

    if (_isPlaying) {
      _isPlaying = false;
    }

    _delay?.cancel();
    _delay = null;
  }

  double? getPlaybackRate() {
    return 1.0;
  }

  Future<void>? setPlaybackRate(double value) async {
    if (!hasPlaybackControl) {
      console.warning('Audio: this Audio has no playback control.');
      return;
    }

    if (_isPlaying) {
      playbackRate = value;
    }
  }

  bool getLoop() {
    if (!hasPlaybackControl) {
      console.warning('Audio: this Audio has no playback control.');
      return false;
    }

    return false;
  }

  Future<void> setLoop(value) async {
    if (!hasPlaybackControl) {
      console.warning('Audio: this Audio has no playback control.');
      return;
    }

    loop = value;
  }

  void setLoopStart(int value) {
    loopStart = value;
  }

  void setLoopEnd(int value) {
    loopEnd = value;
  }

  double? getBalance() {
    return _balance;
  }

  Future<void> setBalance(double value) async {
    _balance = value;
  }

  double? getVolume() {
    return _volume;
  }

  Future<void> setVolume(double value) async {
    _volume = value;
  }
}
