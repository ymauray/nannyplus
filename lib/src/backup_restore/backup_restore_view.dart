import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../src/ui/view.dart';
import '../../utils/database_util.dart';
import '../../utils/snack_bar_util.dart';
import '../child_list/child_list_view.dart';
import '../ui/sliver_curved_persistent_header.dart';

class NewBackupRestoreView extends StatelessWidget {
  const NewBackupRestoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UIView(
      title: Text('${context.t('Backup')} / ${context.t('Restore')}'),
      persistentHeader: const UISliverCurvedPersistenHeader(
        child: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Material(
                elevation: 4,
                shape: Theme.of(context).listTileTheme.shape,
                child: ListTile(
                  title: Text(context.t('Backup')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    await _backup(context);
                    ScaffoldMessenger.of(context).success(
                      context.t('Database successfully backed up'),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Material(
                elevation: 4,
                shape: Theme.of(context).listTileTheme.shape,
                child: ListTile(
                  title: Text(context.t('Restore')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    var success = await _restore(context);
                    if (success) {
                      ScaffoldMessenger.of(context).success(
                        context.t('Database successfully restored'),
                      );
                      Navigator.of(context).popUntil((route) => false);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ChildListView(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).failure(
                        context.t('Error restoring database'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _backup(BuildContext context) async {
    DatabaseUtil.closeDatabase();
    await Share.shareFiles([await DatabaseUtil.databasePath]);
  }

  Future<bool> _restore(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: context.t('Select a backup file'),
      type: FileType.any,
      withData: true,
    );

    if (result != null) {
      var fileBytes = result.files.first.bytes;
      if (fileBytes != null) {
        XFile file = XFile.fromData(fileBytes);
        await DatabaseUtil.closeDatabase();
        await file.saveTo(await DatabaseUtil.databasePath);

        return true;
      }
    }

    return false;
  }
}
