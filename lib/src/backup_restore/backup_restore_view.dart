import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/provider/legacy/child_list_provider.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';
import 'package:nannyplus/views/main_tab_view.dart';
import 'package:share_plus/share_plus.dart';

class BackupRestoreView extends ConsumerWidget {
  const BackupRestoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UIView(
      title: Text('${context.t('Backup')} / ${context.t('Restore')}'),
      persistentHeader: const UISliverCurvedPersistenHeader(
        child: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
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
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                elevation: 4,
                shape: Theme.of(context).listTileTheme.shape,
                child: ListTile(
                  title: Text(context.t('Restore')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final success = await _restore(context);
                    if (success) {
                      ref
                          .read(childListControllerProvider.notifier)
                          .reinitialize();
                      ScaffoldMessenger.of(context).success(
                        context.t('Database successfully restored'),
                      );
                      Navigator.of(context).popUntil((route) => false);
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const MainTabView(),
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
    await DatabaseUtil.closeDatabase();
    await Share.shareXFiles([XFile(await DatabaseUtil.databasePath)]);
  }

  Future<bool> _restore(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: context.t('Select a backup file'),
      withData: true,
    );

    if (result != null) {
      final fileBytes = result.files.first.bytes;
      if (fileBytes != null) {
        final file = XFile.fromData(fileBytes);
        await DatabaseUtil.closeDatabase();
        await file.saveTo(await DatabaseUtil.databasePath);

        return true;
      }
    }

    return false;
  }
}
