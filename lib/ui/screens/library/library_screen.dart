import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../model/songs/song.dart';
import '../../states/player_state.dart';
import '../../states/settings_state.dart';
import '../../theme/theme.dart';
import '../library/view_model/library_view_model.dart';
import '../library/widgets/library_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryViewModel>(
      create: (context) => LibraryViewModel(
        songRepository: context.read<SongRepository>(),
        playerState: context.read<PlayerState>(),
      ),
      child: const LibraryContent(),
    );
  }
}
