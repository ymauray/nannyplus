import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/provider/legacy/child_list_provider.dart';
import 'package:nannyplus/src/backup_restore/backup_restore_view.dart';
import 'package:nannyplus/src/privacy_settings_view/privacy_settings_view.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = context.read<PackageInfo>();

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Image.asset('assets/img/banner1500.png'),
                  Text(
                    'Version ${packageInfo.version} (${packageInfo.buildNumber})',
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                '${context.t('Backup')} / ${context.t('Restore')}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.backup),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    fullscreenDialog: true,
                    builder: (context) => const BackupRestoreView(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                context.t('Privacy settings'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.privacy_tip),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    fullscreenDialog: true,
                    builder: (context) => const PrivacySettingsView(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                context.t('Reset help messages'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.help),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final keys =
                    prefs.getKeys().where((key) => key.startsWith('help_'));
                for (final key in keys) {
                  await prefs.remove(key);
                }
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            if (kDebugMode)
              ListTile(
                title: Text(
                  context.t('Reset database'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.delete_forever_outlined),
                onTap: () async {
                  await DatabaseUtil.deleteDatabase();
                  await (await SharedPreferences.getInstance()).clear();
                  await ref
                      .read(childListControllerProvider.notifier)
                      .loadChildList();
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  static const semaine = Price(
    id: 1,
    label: 'Heures semaine',
    amount: 7,
    fixedPrice: 0,
    sortOrder: 1,
    deleted: 0,
  );
  static const weekend = Price(
    id: 2,
    label: 'Heures weekend',
    amount: 8,
    fixedPrice: 0,
    sortOrder: 2,
    deleted: 0,
  );
  static const petitRepas = Price(
    id: 3,
    label: 'Petit repas',
    amount: 5,
    fixedPrice: 1,
    sortOrder: 3,
    deleted: 0,
  );
  static const grandRepas = Price(
    id: 4,
    label: 'Grand repas',
    amount: 7,
    fixedPrice: 1,
    sortOrder: 4,
    deleted: 0,
  );

  static const fakeNames = [
    {
      'firstName': 'Monique',
      'lastName': 'Grandbois',
      'phoneNumber': '+41 48 899 82 53',
      'parentsName': 'Christelle et Gaston Grandbois',
      'address': 'Hasenbühlstrasse 58\n8715 Bollingen',
    },
    {
      'firstName': 'Anouk',
      'lastName': 'Lampron',
      'phoneNumber': '+41 18 349 79 94',
      'parentsName': 'Valérie et Olivier Lampron',
      'address': 'Kammelenbergstrasse 65\n3065 Flugbrunnen',
    },
    {
      'firstName': 'Thomas',
      'lastName': 'Tanguay',
      'phoneNumber': '+41 26 947 58 67',
      'parentsName': 'Virginie et Armand Tanguay',
      'address': 'Via dalla Staziun 93\n1682 Dompierre',
    },
    {
      'firstName': 'Eloise',
      'lastName': 'Plaisance',
      'phoneNumber': '+41 24 216 93 91',
      'parentsName': 'Catherine et Anton Plaisance',
      'address': 'Piazza Indipendenza 74\n1899 Torgon',
    },
    {
      'firstName': 'Honoré',
      'lastName': 'Clavet',
      'phoneNumber': '+41 44 991 43 47',
      'parentsName': 'Michèle et Gustave Clavet',
      'address': 'Valéestrasse 60\n8913 Ottenbach',
    },
    {
      'firstName': 'Carolos',
      'lastName': 'Lafrenière',
      'phoneNumber': '+41 22 888 86 29',
      'parentsName': 'Astrid et Éric Lafrenière',
      'address': 'Via Schliffras 22\n1211 Genève',
    },
    {
      'firstName': 'Thibaut',
      'lastName': 'Chauvet',
      'phoneNumber': '+41 44 283 83 94',
      'parentsName': 'Émilie et Gaspar Chauvet',
      'address': 'Tösstalstrasse 53\n8360 Wallenwil',
    },
    {
      'firstName': 'Fabien',
      'lastName': 'Bossé',
      'phoneNumber': '+41 44 258 44 38',
      'parentsName': 'Hélène et Alexandre Bossé',
      'address': 'Möhe 62\n8307 Illnau-Effretikon',
    },
  ];
}
