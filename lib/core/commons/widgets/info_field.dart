import 'package:education/core/res/colours.dart';
import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  const InfoField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
    this.onEditingComplete,
    this.hintText,
    this.labelText,
    this.focusNode,
    this.onTapOutside,
    this.onChanged,
    this.suffixIcon,
    this.border = false,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  final TextInputType keyboardType;
  final bool autoFocus;
  final String? labelText;
  final FocusNode? focusNode;

  final ValueChanged<PointerDownEvent>? onTapOutside;
  final ValueChanged<String?>? onChanged;
  final bool border;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    const defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColour),
    );

    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        return TextField(
          controller: controller,
          autofocus: autoFocus,
          focusNode: focusNode,
          keyboardType: keyboardType,
          onEditingComplete: onEditingComplete,
          onTapOutside: onTapOutside ??
              (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: border ? defaultBorder : null,
            enabledBorder: border ? defaultBorder : null,
            contentPadding:
                border ? const EdgeInsets.symmetric(horizontal: 10) : null,
            suffixIcon: suffixIcon ??
                (controller.text.trim().isEmpty
                    ? null
                    : IconButton(
                        onPressed: controller.clear,
                        icon: const Icon(Icons.clear),
                      )),
          ),
        );
      },
    );
  }
}
