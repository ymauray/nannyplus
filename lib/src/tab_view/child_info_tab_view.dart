import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/child_info_cubit.dart';
import 'package:nannyplus/cubit/file_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/src/child_form/profile_photo.dart';
import 'package:nannyplus/src/common/loading_indicator.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

class ChildInfoTabView extends StatelessWidget {
  const ChildInfoTabView({
    super.key,
    required this.childId,
  });

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<ChildInfoCubit>().read(childId);

    return BlocConsumer<ChildInfoCubit, ChildInfoState>(
      listener: (context, state) {
        if (state is ChildInfoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t('Error loading invoices')),
            ),
          );
        }
      },
      builder: (context, state) {
        return state is ChildInfoLoaded
            ? _ChildInfo(child: state.child)
            : const LoadingIndicator();
      },
    );
  }
}

class _ChildInfo extends StatelessWidget {
  const _ChildInfo({
    required this.child,
  });

  final Child child;

  EdgeInsets get labelPadding => const EdgeInsets.only(
        left: kdSmallPadding,
        top: kdSmallPadding,
        right: kdSmallPadding,
      );

  EdgeInsets get fieldPadding => const EdgeInsets.all(kdSmallPadding);

  @override
  Widget build(BuildContext context) {
    context.read<FileListCubit>().loadFiles(child.id ?? 0);
    final profilePhotoController = ProfilePhotoController()..bytes = child.pic;

    return BlocBuilder<FileListCubit, FileListState>(
      builder: (context, state) => UIListView.fromChildren(
        children: [
          if (profilePhotoController.bytes != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilePhoto(
                  controller: profilePhotoController,
                  readonly: true,
                ),
              ],
            ),
          _InfoCard(
            label: context.t('Birthdate'),
            value: child.birthdate?.formatDate() ?? '',
          ),
          _InfoCard(
            label: context.t('Allergies'),
            value: child.allergies ?? context.t('No known allergies'),
          ),
          _InfoCard(
            label: context.t('Parents name'),
            value: child.parentsName ?? '',
          ),
          _InfoCard(
            label: context.t('Address'),
            value: child.address ?? '',
          ),
          _InfoCard(
            label: context.t('Phone number'),
            value: child.phoneNumber ?? '',
          ),
          if ((child.labelForPhoneNumber2?.isNotEmpty ?? false) &&
              (child.phoneNumber2?.isNotEmpty ?? false))
            _InfoCard(
              label: child.labelForPhoneNumber2!,
              value: child.phoneNumber2!,
            ),
          if ((child.labelForPhoneNumber3?.isNotEmpty ?? false) &&
              (child.phoneNumber3?.isNotEmpty ?? false))
            _InfoCard(
              label: child.labelForPhoneNumber3!,
              value: child.phoneNumber3!,
            ),
          if (child.freeText?.isNotEmpty ?? false)
            _InfoCard(
              label: context.t('Free text'),
              value: child.freeText!,
            ),
          if (state is FileListLoaded)
            ...state.files.map(
              (file) => GestureDetector(
                onTap: () {
                  final deviceFile = io.File(file.path);
                  if (deviceFile.existsSync()) {
                    OpenFile.open(file.path);
                  } else if (file.bytes.isNotEmpty) {
                    getTemporaryDirectory().then((tempDir) {
                      final tempFile = io.File('${tempDir.path}/${file.label}')
                        ..writeAsBytesSync(file.bytes);
                      OpenFile.open(tempFile.path);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(context.t('File not found')),
                      ),
                    );
                  }
                },
                child: _InfoCard(
                  label: context.t('Document'),
                  value: file.label,
                  icon: file.bytes.isNotEmpty
                      ? const Icon(
                          FontAwesomeIcons.database,
                          color: Colors.green,
                        )
                      : io.File(file.path).existsSync()
                          ? const Icon(
                              FontAwesomeIcons.fileCircleCheck,
                              color: Colors.green,
                            )
                          : const Icon(
                              FontAwesomeIcons.fileCircleExclamation,
                              color: Colors.red,
                            ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        Padding(
          padding: const EdgeInsets.all(kdMediumPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(
                          fontSize: 12,
                        ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (icon != null) icon!,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
