import 'package:flutter/material.dart';

import 'base_viewmodel.dart';

abstract class BaseView<T extends BaseViewModel> extends StatelessWidget {
  const BaseView({Key? key}) : super(key: key);

  T get viewModel;

  @override
  Widget build(BuildContext context);
}
