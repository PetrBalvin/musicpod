import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../common/view/common_widgets.dart';
import '../../common/view/global_keys.dart';
import '../../common/view/offline_page.dart';
import '../../l10n/l10n.dart';
import '../../player/player_model.dart';
import 'radio_discover_page.dart';

class OpenRadioDiscoverPageButton extends StatelessWidget with WatchItMixin {
  const OpenRadioDiscoverPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isOnline = watchPropertyValue((PlayerModel m) => m.isOnline);
    return ImportantButton(
      onPressed: () {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) =>
                isOnline ? const RadioDiscoverPage() : const OfflinePage(),
          ),
        );
      },
      child: Text(context.l10n.discover),
    );
  }
}
