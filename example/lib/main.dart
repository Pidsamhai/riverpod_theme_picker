import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theme_picker/riverpod_theme_picker.dart';
import 'package:riverpod_theme_picker/widget/theme_picker_service_option.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
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

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod Theme Picker"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    child: const Text("ElevatedButton"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => {},
                    icon: const Icon(Icons.flutter_dash_rounded),
                    label: const Text("ElevatedIconButton"),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: const Text("TextButton"),
                  ),
                ],
              ),
              Text(
                "Display L",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                "Display M",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Display S",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                "Headline L",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "Headline M",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Headline S",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Title L",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Title M",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Title S",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "Body L",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Body M",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Body S",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: "Noti",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ThemePickerPage(),
            ),
          );
        },
        child: const Icon(Icons.color_lens_rounded),
      ),
    );
  }
}
