import 'package:flutter/material.dart';

abstract class TimePicker extends StatelessWidget {
  const TimePicker({Key? key}) : super(key: key);

  static Future<T?> show<T>({
    required BuildContext context,
    required TimePicker sheet,
    bool dismissible = true,
    ShapeBorder? shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: dismissible,
      shape: shape,
      isDismissible: dismissible,
      builder: (_) => sheet,
    );
  }
}
