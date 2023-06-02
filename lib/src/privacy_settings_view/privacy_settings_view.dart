import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';

class _Header extends ConsumerWidget {
  const _Header({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PrivacySettingsView extends StatelessWidget {
  const PrivacySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return UIView(
      title: Text(context.t('Privacy settings')),
      persistentHeader: const UISliverCurvedPersistenHeader(child: Text('')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(title: 'Dernière mise à jour : 1er Juin 2023'),
              Text(
                'Cette politique de confidentialité décrit comment l\'application Nanny+ ("nous", "notre", "nos", "l\'application") collecte, utilise, partage et protège les informations personnelles que vous ("l\'utilisateur") nous fournissez lorsque vous utilisez l\'application.',
              ),
              _Header(
                title: 'Collecte et utilisation des informations',
              ),
              Text(
                "Les données de l'application sont uniquement enregistrées sur le téléphone. Aucune données ne sort sur Internet. Nanny+ respecte votre vie privée et celles des enfants que vous gardez. Nous ne collectons, ne stockons ni n’utilisons aucune donnée utilisateur depuis l'application. Dans le cas où nous aurions besoin de recueillir vos données, nous veillerons à vous fournir un préavis adéquat.",
              ),
              _Header(title: 'Google Analytics'),
              Text(
                "Notre application utilise Google Analytics, un service qui transmet des données anonymes aux serveurs de Google aux États-Unis. Google Analytics ne vous identifie pas personnellement mais peut suivre votre utilisation de l'application, combien de temps vous passez sur l'application, la fréquence et le comportement de votre usage.",
              ),
              Text(
                "Google peut utiliser les informations recueillies pour contextualiser et personnaliser les annonces de son propre réseau publicitaire. L'utilisation de Google Analytics par notre application est en conformité avec la politique de confidentialité de Google, que vous pouvez trouver ici : http://www.google.com/policies/privacy/.",
              ),
              _Header(title: 'Modifications'),
              Text(
                'Cette politique de confidentialité peut être modifiée à l’occasion afin de maintenir la conformité avec la loi et de tenir compte de tout changement à notre processus de collecte de données. Nous recommandons à nos utilisateurs de vérifier notre politique de temps à autre pour s’assurer qu’ils soient informés de toute mise à jour.',
              ),
              _Header(title: 'Contact'),
              Text(
                'Si vous avez des questions à nous poser, n’hésitez pas à communiquer avec nous en utilisant ce qui suit :',
              ),
              Text('* Par mail : contact@nannyplus.ch'),
            ],
          ),
        ),
      ),
    );
  }
}
