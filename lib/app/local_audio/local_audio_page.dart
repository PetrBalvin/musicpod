import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:music/app/common/audio_list.dart';
import 'package:music/app/common/search_field.dart';
import 'package:music/app/local_audio/local_audio_model.dart';
import 'package:music/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class LocalAudioPage extends StatelessWidget {
  const LocalAudioPage({super.key, this.showWindowControls = true});

  final bool showWindowControls;

  @override
  Widget build(BuildContext context) {
    final localAudioModel = context.watch<LocalAudioModel>();
    final theme = Theme.of(context);

    final page =
        localAudioModel.directory == null || localAudioModel.directory!.isEmpty
            ? Center(
                child: ElevatedButton(
                  onPressed: () async {
                    localAudioModel.directory = await getDirectoryPath();
                    await localAudioModel.init();
                  },
                  child: const Text('Pick your music collection'),
                ),
              )
            : localAudioModel.audios == null
                ? const Center(
                    child: YaruCircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AudioList(
                      likeButton: const SizedBox.shrink(),
                      deletable: false,
                      editableName: false,
                      listName: context.l10n.localAudio,
                      audios: localAudioModel.audios!,
                    ),
                  );

    final appBar = YaruWindowTitleBar(
      style: showWindowControls
          ? YaruTitleBarStyle.normal
          : YaruTitleBarStyle.undecorated,
      leading: Navigator.of(context).canPop()
          ? const YaruBackButton(
              style: YaruBackButtonStyle.rounded,
            )
          : const SizedBox(
              width: 40,
            ),
      title: SearchField(spawnPageWithWindowControls: showWindowControls),
    );

    return YaruDetailPage(
      backgroundColor: theme.brightness == Brightness.dark
          ? const Color.fromARGB(255, 37, 37, 37)
          : Colors.white,
      appBar: appBar,
      body: page,
    );
  }
}
