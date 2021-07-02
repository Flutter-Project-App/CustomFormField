import 'package:flutter/material.dart';

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
    MaterialTapTargetSize? materialTapTargetSize,
    Color? focusColor,
    Color? hoverColor,
    FocusNode? focusNode,
    bool autofocus = false,
  }) : assert(decoration != null),
        assert(initialValue != null),
        assert(autovalidate != null),
        assert(autofocus != null),
        assert(constraints != null),
        super(
            key: key,
            onSaved: onSaved,
            initialValue: initialValue,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> field) {
              final InputDecoration effectiveDecoration = decoration
                  .applyDefaults(Theme.of(field.context).inputDecorationTheme);
              return InputDecorator(
                decoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                isEmpty: field.value == null,
                isFocused: focusNode!.hasFocus,
                child: Row(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: constraints,
                      child: Switch(
                        value: field.value!,
                        onChanged: field.didChange,
                        activeColor: activeColor,
                        inactiveThumbColor: inactiveThumbColor,
                        inactiveTrackColor: inactiveTrackColor,
                        activeTrackColor: activeTrackColor,
                        materialTapTargetSize: materialTapTargetSize,
                        focusColor: focusColor,
                        hoverColor: hoverColor,
                        focusNode: focusNode,
                        autofocus: autofocus,
                      ),
                    )
                  ],
                ),
              );
            });

  final ValueChanged<bool>? onChanged;
  final InputDecoration decoration;
  final BoxConstraints constraints;

  @override
  FormFieldState<bool> createState() => _SwitchFormFieldState();
}

class _SwitchFormFieldState extends FormFieldState<bool> {
  @override
  SwitchFormField get widget => widget;

  @override
  void didChange(bool? value) {
    // TODO: implement didChange
    super.didChange(value);
    if (this.hasError) {
      this.validate();
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value!);
    }
  }
}
