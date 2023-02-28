# Riverpod Theme Picker

A new Flutter plugin project.

using flex color scheme and google fonts

![Art](/art/art.gif)

Example

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        // Init Theme Service
        await ThemeServiceProvider.override(
          const ThemePickerServiceOption(
            fontfamilies: [
              "Pattaya",
              "Kanit",
              "Bai Jamjuree",
              "Prompt",
              "Krub",
              "Itim",
            ],
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
```

Material App

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "Riverpod Theme Picker",
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themePickerServiceProvider).flexLightTheme,
      darkTheme: ref.watch(themePickerServiceProvider).flexDarkTheme,
      themeMode: ref.watch(themePickerServiceProvider).themeMode,
      home: const Home(),
    );
  }
}
```

