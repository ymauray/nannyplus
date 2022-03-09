import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/views/app_view.dart';

class ChildForm extends StatelessWidget {
  final Child? child;

  const ChildForm({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView(
      title: Text(
          child != null ? context.t('Edit Child') : context.t('Add Child')),
      body: Container(),
    );
  }
}
