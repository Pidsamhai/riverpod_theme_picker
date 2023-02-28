import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../provider/theme_picker_service_provider.dart';
import 'spacer_box.dart';

class ThemePreviewWidget extends StatelessWidget {
  final ThemeMap themeMap;
  final bool selected;
  final VoidCallback? onTab;
  const ThemePreviewWidget({
    super.key,
    required this.themeMap,
    this.selected = false,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTab,
          child: Container(
            width: 100,
            height: 150,
            margin: const EdgeInsets.all(4),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: themeMap.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withAlpha(50),
                width: 2,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 20,
                      color: themeMap.theme.appBarTheme.backgroundColor,
                    ),
                    SpaceBox.ss,
                    SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: Card(
                        color: themeMap.theme.colorScheme.primaryContainer,
                      ),
                    ),
                    SpaceBox.l,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: themeMap
                                    .theme.colorScheme.onPrimaryContainer,
                              ),
                              height: 15,
                            ),
                          ),
                          SpaceBox.ss,
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  themeMap.theme.colorScheme.primaryContainer,
                            ),
                            height: 15,
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    const Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    Container(
                      height: 25,
                      width: double.maxFinite,
                      color: themeMap.theme.colorScheme.surfaceVariant,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(100),
                            ),
                            height: 15,
                            width: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: themeMap
                                  .theme.navigationBarTheme.indicatorColor,
                            ),
                            height: 15,
                            width: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(100),
                            ),
                            height: 15,
                            width: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if (selected)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(1),
                      margin: const EdgeInsets.only(top: 2, right: 2),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Text(
          themeMap.name.split(".").last.capitalize,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
