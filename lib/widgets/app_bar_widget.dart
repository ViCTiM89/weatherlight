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
            final navigator = Navigator.of(context);

            bool confirmExit = await confirmExitDialog(context);
            if (confirmExit) {
              navigator.pop();
            }
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
