import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../pages/signupForm.dart';

class SwitchFormField extends FormField<bool> {
  SwitchFormField({
    Key? key,
    bool? initialValue,
    this.decoration = const InputDecoration(),
    this.onChanged,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool autovalidate = false,
    this.constraints = const BoxConstraints(),
    Color? activeColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
    // ImageProvider<dynamic>? activeThumbImage,
    // ImageProvider<dynamic>? inactiveThumbImage,
    MaterialTapTargetSize? materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color? focusColor,
    Color? hoverColor,
    FocusNode? focusNode,
    bool autofocus = false,
  }) : assert(decoration != null),
        assert(initialValue != null),
        assert(autovalidate != null),
        assert(autofocus != null),
        assert(dragStartBehavior != null),
        assert(constraints != null),
        super(
        key: key,
        onSaved: onSaved,
        initialValue: initialValue,
        validator: validator,
        autovalidate: autovalidate,
        builder: (FormFieldState<bool>? field) {
          final InputDecoration effectiveDecoration = decoration!.applyDefaults(
            Theme.of(field!.context).inputDecorationTheme,
          );
          return InputDecorator(
            decoration: effectiveDecoration.copyWith(errorText: field.errorText),
            isEmpty: field.value == null,
            isFocused: focusNode!.hasFocus,
            child: Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: constraints!,
                  child: Switch(
                    value: field.value!,
                    onChanged: field.didChange,
                    activeColor: activeColor,
                    activeTrackColor: activeTrackColor,
                    inactiveThumbColor: inactiveThumbColor,
                    inactiveTrackColor: inactiveTrackColor,
                    // activeThumbImage: activeThumbImage,
                    // inactiveThumbImage: inactiveThumbImage,
                    materialTapTargetSize: materialTapTargetSize,
                    dragStartBehavior: dragStartBehavior,
                    focusColor: focusColor,
                    hoverColor: hoverColor,
                    focusNode: focusNode,
                    autofocus: autofocus,
                  ),
                ),
              ],
            ),
          );
        },
      );

  final ValueChanged<bool>? onChanged;
  final InputDecoration? decoration;
  final BoxConstraints? constraints;

  @override
  FormFieldState<bool> createState() => _SwitchFormFieldState();
}

class _SwitchFormFieldState extends FormFieldState<bool> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  SwitchFormField get widget => super.widget as SwitchFormField;

  @override
  void didChange(bool? value) {
    super.didChange(value);
    if (this.hasError) {
      this.validate();
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value!);
    }
  }
}
