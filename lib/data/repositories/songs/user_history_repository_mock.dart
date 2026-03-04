import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  final List<String> _history = ['1', '2', '3'];

  @override
  List<String> fetchRecentSongIds() => List.unmodifiable(_history);

  @override
  Future<void> addSongToHistory(String songId) async {
    _history.remove(songId);
    _history.insert(0, songId);
  }
}
