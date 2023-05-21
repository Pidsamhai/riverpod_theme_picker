import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theme_picker/provider/theme_picker_service_provider.dart';

import 'spacer_box.dart';
import 'theme_preview.dart';

class ThemePickerPage extends ConsumerStatefulWidget {
  const ThemePickerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThemePickerPageState();
}

class _ThemePickerPageState extends ConsumerState<ThemePickerPage> {
  @override
  Widget build(BuildContext context) {
    final selectedThemeMode = [
      ref.watch(themePickerServiceProvider).themeMode == ThemeMode.system,
      ref.watch(themePickerServiceProvider).themeMode == ThemeMode.light,
      ref.watch(themePickerServiceProvider).themeMode == ThemeMode.dark,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(themePickerServiceProvider).option.label.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.read(themePickerServiceProvider).option.label.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SpaceBox.s,
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    mainAxisExtent: 180,
                  ),
                  shrinkWrap: true,
                  itemCount:
                      ref.read(themePickerServiceProvider).lightThemes.length,
                  itemBuilder: (context, index) {
                    return ThemePreviewWidget(
                      themeMap: ref
                          .read(themePickerServiceProvider)
                          .lightThemes[index],
                      selected:
                          ref.read(themePickerServiceProvider).themeIndex ==
                              index,
                      onTab: () => ref
                          .read(themePickerServiceProvider)
                          .themeIndex = index,
                    );
                  },
                ),
                Text(
                  ref.read(themePickerServiceProvider).option.label.font,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      ref.read(themePickerServiceProvider).fonts?.length ?? 0,
                  itemBuilder: (context, index) {
                    final font = ref
                        .read(themePickerServiceProvider)
                        .fonts![index]
                        .style;
                    return ListTile(
                      title: Text(
                        ref
                            .read(themePickerServiceProvider)
                            .option
                            .label
                            .fontExample,
                        style: font,
                      ),
                      subtitle: Text(
                        font.fontFamily ?? "",
                        style: font,
                      ),
                      selected: true,
                      trailing: ref
                                  .read(themePickerServiceProvider)
                                  .selectedFontIndex ==
                              index
                          ? const Icon(
                              Icons.check_circle,
                            )
                          : null,
                      onTap: () {
                        ref.read(themePickerServiceProvider).selectedFontIndex =
                            index;
                      },
                    );
                  },
                ),
                Text(
                  ref.read(themePickerServiceProvider).option.label.mode,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SpaceBox.ss,
                ToggleButtons(
                  isSelected: selectedThemeMode,
                  onPressed: (int index) {
                    ref.read(themePickerServiceProvider).themeMode =
                        ref.read(themePickerServiceProvider).themeModes[index];
                  },
                  children: const <Widget>[
                    Icon(Icons.phone_android_rounded),
                    Icon(Icons.light_mode_rounded),
                    Icon(Icons.dark_mode_rounded),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
