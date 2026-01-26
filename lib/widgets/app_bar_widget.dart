import 'package:flutter/material.dart';

import '../game_helper.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  const SharedAppBar({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            final currentContext = context;

            bool confirmExit = await confirmExitDialog(currentContext);
            if (confirmExit) {
              Navigator.of(currentContext).pop();
            }
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
