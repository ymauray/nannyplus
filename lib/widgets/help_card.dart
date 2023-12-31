import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nannyplus/provider/help_card_status_provider.dart';

class HelpCard extends ConsumerWidget {
  const HelpCard(this.helpText, {super.key});

  final String helpText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(helpCardStatusProvider(helpText.hashCode));

    return status.when(
      loading: Container.new,
      error: (error, stackTrace) => Container(),
      data: (isShow) => !isShow
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                  border: Border.all(
                    color: Colors.yellow.shade800,
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(helpText),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(
                              helpCardStatusProvider(helpText.hashCode)
                                  .notifier,
                            )
                            .hide();
                      },
                      icon: const Icon(Icons.close),
                      padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
