import 'package:flutter/widgets.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song> _songs = [];

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    init();
    playerState.addListener(_onPlayerStateChanged);
  }
  void init() {
    _songs = songRepository.fetchSongs();
    notifyListeners();
  }

  void _onPlayerStateChanged() {
    notifyListeners();
  }

  List<Song> get songs => _songs;

  bool isPlaying(Song song) => playerState.currentSong == song;

  void play(Song song) {
    playerState.start(song);
  }
}
