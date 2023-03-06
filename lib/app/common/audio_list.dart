import 'package:flutter/material.dart';
import 'package:music/app/common/audio_tile.dart';
import 'package:music/app/local_audio/local_audio_model.dart';
import 'package:music/app/player_model.dart';
import 'package:music/app/playlists/playlist_dialog.dart';
import 'package:music/app/playlists/playlist_model.dart';
import 'package:music/data/audio.dart';
import 'package:music/l10n/l10n.dart';
import 'package:music/utils.dart';
import 'package:provider/provider.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AudioList extends StatefulWidget {
  const AudioList({
    super.key,
    required this.audios,
    this.isLikedIcon,
    this.listName,
    this.editableName = true,
    required this.deletable,
    this.onLike,
    this.isLiked,
    this.isUnLikedIcon,
    this.onUnLike,
    this.likeButton,
    this.showTrack = true,
  });

  final Set<Audio> audios;
  final Widget? isLikedIcon;
  final Widget? isUnLikedIcon;
  final void Function(String name, Set<Audio> audios)? onLike;
  final void Function(String name)? onUnLike;
  final String? listName;

  final bool editableName;
  final bool deletable;
  final bool Function(Audio)? isLiked;
  final Widget? likeButton;
  final bool showTrack;

  @override
  State<AudioList> createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  AudioFilter _filter = AudioFilter.album;

  late ScrollController _controller;
  int _amount = 40;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        setState(() {
          _amount++;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerModel = context.watch<PlayerModel>();
    final playlistModel = context.watch<PlaylistModel>();
    final theme = Theme.of(context);

    var sortedAudios = widget.audios.toList();

    sortListByAudioFilter(audioFilter: _filter, audios: sortedAudios);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 15,
          ),
          child: AudioListControlPanel(
            deletable: widget.deletable,
            editableName: widget.editableName,
            audios: sortedAudios.toSet(),
            listName: widget.listName,
            likeButton: widget.likeButton,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: AudioListHeader(
            showTrack: widget.showTrack,
            audioFilter: _filter,
            onAudioFilterSelected: (audioFilter) => setState(() {
              _filter = audioFilter;
            }),
          ),
        ),
        const Divider(
          height: 0,
        ),
        Expanded(
          child: ListView.builder(
            controller: _controller,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            itemCount: sortedAudios.take(_amount).length,
            itemBuilder: (context, index) {
              final audio = sortedAudios.elementAt(index);
              final audioSelected = playerModel.audio == audio;

              bool liked = widget.isLiked != null
                  ? widget.isLiked!(audio)
                  : playlistModel.liked(audio);

              return AudioTile(
                isPlayerPlaying: playerModel.isPlaying,
                pause: playerModel.pause,
                play: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((timeStamp) async {
                    if (context.mounted) {
                      playerModel.audio = audio;
                      await playerModel.play();
                    }
                  });
                },
                key: ValueKey(audio),
                selected: audioSelected,
                audio: audio,
                likeIcon: widget.onLike != null &&
                        widget.onUnLike != null &&
                        widget.isLikedIcon != null &&
                        widget.isUnLikedIcon != null
                    ? liked
                        ? YaruIconButton(
                            icon: widget.isLikedIcon!,
                            onPressed: audio.name == null
                                ? null
                                : () => widget.onUnLike!(audio.name!),
                          )
                        : YaruIconButton(
                            icon: widget.isUnLikedIcon!,
                            onPressed: audio.name == null
                                ? null
                                : () => widget.onLike!(audio.name!, {audio}),
                          )
                    : YaruPopupMenuButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.circular(kYaruButtonRadius),
                          ),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Text(context.l10n.createNewPlaylist),
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return ChangeNotifierProvider.value(
                                    value: playlistModel,
                                    child: PlaylistDialog(
                                      deletable: true,
                                      editableName: true,
                                      audios: {audio},
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (playlistModel.playlists
                                .containsKey(widget.listName))
                              PopupMenuItem(
                                child: Text('Remove from ${widget.listName}'),
                                onTap: () =>
                                    playlistModel.removeAudioFromPlaylist(
                                  widget.listName!,
                                  audio,
                                ),
                              ),
                            for (final playlist in playlistModel
                                .playlists.entries
                                .take(5)
                                .toList())
                              if (playlist.key != 'likedAudio')
                                PopupMenuItem(
                                  child: Text(
                                    '${context.l10n.addTo} ${playlist.key == 'likedAudio' ? context.l10n.likedSongs : playlist.key}',
                                  ),
                                  onTap: () => playlistModel.addAudioToPlaylist(
                                    playlist.key,
                                    audio,
                                  ),
                                )
                          ];
                        },
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => liked
                              ? playlistModel.removeLikedAudio(audio)
                              : playlistModel.addLikedAudio(audio),
                          child: Icon(
                            liked ? YaruIcons.heart_filled : YaruIcons.heart,
                            color: audioSelected
                                ? theme.colorScheme.onSurface
                                : theme.hintColor,
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AudioListControlPanel extends StatelessWidget {
  const AudioListControlPanel({
    super.key,
    required this.audios,
    this.listName,
    this.editableName = true,
    required this.deletable,
    this.likeButton,
  });

  final Set<Audio> audios;
  final String? listName;
  final bool editableName;
  final bool deletable;
  final Widget? likeButton;

  @override
  Widget build(BuildContext context) {
    final playlistModel = context.watch<PlaylistModel>();
    final playerModel = context.watch<PlayerModel>();
    final theme = Theme.of(context);
    final listIsQueue = listsAreEqual(playerModel.queue, audios.toList());
    final allLiked =
        audios.where((a) => playlistModel.liked(a)).toList().length ==
            audios.length;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: theme.colorScheme.inverseSurface,
          child: IconButton(
            onPressed: () {
              if (playerModel.isPlaying) {
                if (listIsQueue) {
                  playerModel.pause();
                } else {
                  playerModel.startPlaylist(audios);
                }
              } else {
                if (listIsQueue) {
                  playerModel.resume();
                } else {
                  playerModel.startPlaylist(audios);
                }
              }
            },
            icon: Icon(
              playerModel.isPlaying && listIsQueue
                  ? YaruIcons.media_pause
                  : YaruIcons.media_play,
              color: theme.colorScheme.onInverseSurface,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (likeButton != null)
          likeButton!
        else
          IconButton(
            onPressed: () => allLiked
                ? playlistModel.removeLikedAudios(audios)
                : playlistModel.addLikedAudios(audios),
            icon: Icon(
              allLiked ? YaruIcons.heart_filled : YaruIcons.heart,
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        if (editableName || deletable)
          YaruIconButton(
            icon: const Icon(YaruIcons.pen),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => ChangeNotifierProvider<PlaylistModel>.value(
                value: playlistModel,
                child: PlaylistDialog(
                  editableName: editableName,
                  deletable: deletable,
                  name: listName,
                  audios: audios,
                ),
              ),
            ),
          ),
        if (listName != null)
          Expanded(
            child: Text(
              '${listName == 'likedAudio' ? context.l10n.likedSongs : listName ?? ''}  •  ${audios.length} ${context.l10n.titles}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w100),
            ),
          ),
      ],
    );
  }
}

class AudioListHeader extends StatelessWidget {
  const AudioListHeader({
    super.key,
    this.onAudioFilterSelected,
    required this.audioFilter,
    this.showTrack = true,
  });

  final void Function(AudioFilter audioFilter)? onAudioFilterSelected;
  final AudioFilter audioFilter;
  final bool showTrack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 8, right: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kYaruButtonRadius),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showTrack)
            _HeaderElement(
              onAudioFilterSelected: onAudioFilterSelected,
              label: '#',
              audioFilter: AudioFilter.trackNumber,
              flex: 1,
            ),
          _HeaderElement(
            onAudioFilterSelected: onAudioFilterSelected,
            label: context.l10n.title,
            audioFilter: AudioFilter.title,
            flex: 5,
          ),
          _HeaderElement(
            onAudioFilterSelected: onAudioFilterSelected,
            label: context.l10n.artist,
            audioFilter: AudioFilter.artist,
            flex: 4,
          ),
          _HeaderElement(
            onAudioFilterSelected: onAudioFilterSelected,
            label: context.l10n.album,
            audioFilter: AudioFilter.album,
            flex: 4,
          ),
        ],
      ),
      trailing: YaruPopupMenuButton<AudioFilter>(
        initialValue: audioFilter,
        onSelected: onAudioFilterSelected,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(kYaruButtonRadius),
          ),
        ),
        child: Icon(
          YaruIcons.ordered_list,
          color: theme.colorScheme.onSurface,
        ),
        itemBuilder: (a) => [
          for (final filter in AudioFilter.values)
            PopupMenuItem(
              value: filter,
              child: Text(filter.name),
            )
        ],
      ),
    );
  }
}

class _HeaderElement extends StatelessWidget {
  const _HeaderElement({
    this.onAudioFilterSelected,
    required this.label,
    required this.audioFilter,
    this.flex = 1,
  });

  final void Function(AudioFilter audioFilter)? onAudioFilterSelected;
  final AudioFilter audioFilter;
  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w100,
    );
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: onAudioFilterSelected == null
                ? null
                : () => onAudioFilterSelected!(audioFilter),
            child: Text(
              label,
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
