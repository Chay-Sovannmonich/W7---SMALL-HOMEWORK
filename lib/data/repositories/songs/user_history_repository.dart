abstract class UserHistoryRepository {
  List<String> fetchRecentSongIds();
  Future<void> addSongToHistory(String songId);
}
