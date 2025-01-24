import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:flutter_easy_dialogs_error_showcase/src/settings/settings_view.dart';

class FeatureView extends StatelessWidget {
  const FeatureView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextButton(
                onPressed: showDialog,
                child: Text('Show Fullscreen Dialog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _dialogId = 'dialog';
const _modalId = 'modal';

Future<void> showDialog() async {
  final dialog = EasyDialog.fullScreen(
    id: _dialogId,
    androidWillPop: () => false,
    content: Container(
      color: Colors.blue[900],
      alignment: Alignment.center,
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Fullscreen Dialog',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          TextButton(
            onPressed: () async {
              await showModalDialog();
            },
            child: Text('Show Modal'),
          ),
          TextButton(
            onPressed: () async {
              await showModalDialogError();
            },
            child: Text('Show Modal with Error'),
          ),
          TextButton(
            onPressed: () async {
              await FlutterEasyDialogs.hide(id: _dialogId, instantly: true);
            },
            child: Text('Hide Fullscreen Dialog'),
          ),
        ],
      ),
    ),
  );

  await dialog.show();
}

Future<void> showModalDialog() async {
  final modal = EasyDialog.positioned(
    id: _modalId,
    position: EasyDialogPosition.bottom,
    autoHideDuration: null,
    decoration: EasyDialogAnimation.fadeBackground(),
    content: Container(
      height: 300,
      color: Colors.green[900],
      alignment: Alignment.center,
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Modal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          TextButton(
              onPressed: () async {
                await FlutterEasyDialogs.hide(id: _modalId, instantly: true);
              },
              child: Text('Hide Modal')),
        ],
      ),
    ),
  );

  await modal.show();
}

Future<void> showModalDialogError() async {
  await Container(
    height: 300,
    color: Colors.green[900],
    alignment: Alignment.center,
    child: Column(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Modal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        TextButton(
            onPressed: () async {
              try {
                await FlutterEasyDialogs.hide(id: _modalId, instantly: true);
              } catch (e, st) {
                log('showModalDialogError', error: e, stackTrace: st);
              }
            },
            child: Text('Hide Modal')),
      ],
    ),
  )
      .positioned(
        id: _modalId,
        position: EasyDialogPosition.bottom,
        autoHideDuration: null,
      )
      .fadeBackground()
      .show();
}
