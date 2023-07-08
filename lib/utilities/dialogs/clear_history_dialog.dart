import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showClearHistoryDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Clear Chat History',
    content: 'Are you sure you want to clear your chat history?',
    optionsBuilder: () => {
      'Cancel': false,
      'Confirm': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
