import 'package:flutter/widgets.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../data/repositories/songs/user_history_repository.dart';
import '../../../../model/songs/song.dart';
import '../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final UserHistoryRepository userHistoryRepository;
  final PlayerState playerState;

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  HomeViewModel({
    required this.songRepository,
    required this.userHistoryRepository,
    required this.playerState,
  }) {
    init();
    playerState.addListener(_onPlayerStateChanged);
  }

  void init() {
    final allSongs = songRepository.fetchSongs();
    final recentIds = userHistoryRepository.fetchRecentSongIds();

    _recentSongs = [];
    for (String id in recentIds) {
      final song = allSongs.firstWhere((s) => s.id == id);
      _recentSongs.add(song);
    }

    _recommendedSongs = [];
    for (Song song in allSongs) {
      if (!recentIds.contains(song.id)) {
        _recommendedSongs.add(song);
      }
    }

    notifyListeners(); 
  }

  void _onPlayerStateChanged() => notifyListeners();

  List<Song> get recentSongs => _recentSongs;
  List<Song> get recommendedSongs => _recommendedSongs;
  bool isPlaying(Song song) => playerState.currentSong == song;

  void play(Song song) => playerState.start(song);
  void stop() => playerState.stop();

  @override
  void dispose() {
    playerState.removeListener(_onPlayerStateChanged); 
    super.dispose();
  }
}
