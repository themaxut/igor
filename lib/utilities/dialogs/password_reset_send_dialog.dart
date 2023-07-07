import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showPasswordResetSendDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Password Reset',
      content:
          'We have now sent you a password reset link. Please check your email for more information.',
      optionsBuilder: () => {
            'OK': null,
          });
}
