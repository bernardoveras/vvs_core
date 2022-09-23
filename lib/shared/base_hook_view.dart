import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'base_viewmodel.dart';

abstract class BaseHookView<T extends BaseViewModel> extends HookWidget {
  const BaseHookView({Key? key}) : super(key: key);

  T get viewModel;

  @override
  Widget build(BuildContext context);
}
