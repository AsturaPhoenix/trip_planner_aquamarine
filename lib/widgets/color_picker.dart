import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<Color?> showColorPicker({
  required BuildContext context,
  required Color initialColor,
}) =>
    showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(initialColor: initialColor),
    );

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key, required this.initialColor});

  final Color initialColor;

  @override
  State<StatefulWidget> createState() => ColorPickerDialogState();
}

class ColorPickerDialogState extends State<ColorPickerDialog>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.initialColor;
  }

  void _onColorChanged(Color color) {
    setState(() => this.color = color);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = MaterialLocalizations.of(context);

    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final portrait = constraints.maxHeight > 600;

          return SizedBox(
            width: portrait ? 360 : 640,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: theme.colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 12, 8),
                    child: Text(
                      'SELECT COLOR',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                ),
                Material(
                  color: theme.colorScheme.secondary,
                  child: TabBar(
                    controller: tabController,
                    tabs: const [Text('Palette'), Text('Custom')],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: portrait ? 458 : 153,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        BlockPicker(
                          pickerColor: color,
                          onColorChanged: _onColorChanged,
                          layoutBuilder: (context, colors, child) =>
                              GridView.count(
                            crossAxisCount: portrait ? 4 : 10,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: [
                              for (final color in colors) child(color)
                            ],
                          ),
                        ),
                        ColorPicker(
                          portraitOnly: portrait,
                          pickerColor: color,
                          onColorChanged: _onColorChanged,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  constraints: const BoxConstraints(minHeight: 52.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: OverflowBar(
                    spacing: 8,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:
                            Text(localizations.cancelButtonLabel.toUpperCase()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, color),
                        child: Text(localizations.okButtonLabel),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
