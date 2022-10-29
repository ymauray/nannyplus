import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';

class PrivacySettingsView extends StatelessWidget {
  const PrivacySettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UIView(
      title: Text(context.t('Privacy settings')),
      persistentHeader: const UISliverCurvedPersistenHeader(child: Text('')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Données personnelles que nous collectons',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Nous ne collectons, ne stockons ni n’utilisons aucune donnée utilisateur depuis l'application. Dans le cas où nous aurions besoin de recueillir vos données, nous veillerons à vous fournir un préavis adéquat.",
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 8),
              child: Text(
                'Modifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Cette politique de confidentialité peut être modifiée à l’occasion afin de maintenir la conformité avec la loi et de tenir compte de tout changement à notre processus de collecte de données. Nous recommandons à nos utilisateurs de vérifier notre politique de temps à autre pour s’assurer qu’ils soient informés de toute mise à jour.',
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 8),
              child: Text(
                'Contact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Si vous avez des questions à nous poser, n’hésitez pas à communiquer avec nous en utilisant ce qui suit :',
            ),
            Text('* Sur twitter : @NannyPlusApp'),
            Text('* Par mail : contact@nannyplus.ch'),
          ],
        ),
      ),
    );
  }
}
