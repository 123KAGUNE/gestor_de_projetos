import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/storage/local_storage.dart';
import 'providers/providers.dart';
import 'screens/home_screen.dart';
import 'screens/project_form_screen.dart';
import 'screens/project_detail_screen.dart';
import 'screens/task_form_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await ThemeProvider().init();
  runApp(const ProjectManagerApp());
}

class ProjectManagerApp extends StatelessWidget {
  const ProjectManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProjectsProvider()),
        ChangeNotifierProvider(create: (_) => TasksProvider()),
        ChangeNotifierProvider(create: (_) => DecisionsProvider()),
        ChangeNotifierProvider(create: (_) => DiaryProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Gestor de Projetos',
            debugShowCheckedModeBanner: false,
            theme: buildAppTheme(isDarkMode: themeProvider.isDarkMode),
            home: const HomeScreen(),
            routes: {
              '/home': (context) => const HomeScreen(),
              '/project-form': (context) {
                final args = ModalRoute.of(context)?.settings.arguments as Map?;
                return ProjectFormScreen(project: args?['project']);
              },
              '/project-detail': (context) {
                final project =
                    ModalRoute.of(context)?.settings.arguments as dynamic;
                return ProjectDetailScreen(project: project);
              },
              '/task-form': (context) {
                final args =
                    ModalRoute.of(context)?.settings.arguments as Map? ?? {};
                return TaskFormScreen(
                  projectId: args['projectId'] ?? '',
                  task: args['task'],
                );
              },
            },
          );
        },
      ),
    );
  }
}
