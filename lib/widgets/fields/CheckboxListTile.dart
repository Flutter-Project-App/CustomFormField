import 'package:flutter/material.dart';

class CustomCheckboxListTile<T> extends StatefulWidget {
  CustomCheckboxListTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onChanged,
    required this.selected,
    this.activeColor,
    this.checkColor,
    this.dense,
    this.isThreeLine = false,
    this.secondary
  }):
        assert(title != null),
        assert(onChanged != null),
        assert(selected != null),
        super(key: key);

  final Widget? title;
  final Widget? subtitle;
  final dynamic onChanged;
  final bool? selected;
  final Color? activeColor;
  final Color? checkColor;
  final bool? isThreeLine;
  final bool? dense;
  final Widget? secondary;

  @override
  _CustomCheckboxListTileState<T> createState() => _CustomCheckboxListTileState<T>();
}

class _CustomCheckboxListTileState<T> extends State<CustomCheckboxListTile<T>> {
  _CustomCheckboxListTileState();

  bool? _checked;

  @override
  void initState(){
    _checked = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _checked,
      selected: _checked!,
      title: widget.title,
      subtitle: widget.subtitle,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) {
        widget.onChanged!(checked);
        setState((){
          _checked = checked!;
        });
      },
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      isThreeLine: widget.isThreeLine!,
      dense: widget.dense,
      secondary: widget.secondary,
    );
  }
}

class ChipList<T> extends StatelessWidget {
  const ChipList({
    required this.values,
    required this.chipBuilder,
    this.spacing = 8.0,
    this.alignment = WrapAlignment.start,
  });

  final List<T> values;
  final Chip Function(T) chipBuilder;
  final double spacing;
  final WrapAlignment alignment;

  List<Widget> _buildChipList() {
    final List<Widget> items = [];
    for (T value in values) {
      items.add(chipBuilder(value));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      alignment: alignment,
      children: _buildChipList(),
    );
  }
}
