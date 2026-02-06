import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimen.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'project_form_screen.dart';
import 'project_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega os dados ao iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectsProvider>().loadProjects();
      context.read<TasksProvider>().loadTasks();
      context.read<DecisionsProvider>().loadDecisions();
      context.read<DiaryProvider>().loadDiaryEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Projetos'),
        elevation: 0,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
                tooltip: themeProvider.isDarkMode ? 'Modo Claro' : 'Modo Escuro',
              );
            },
          ),
        ],
      ),
      body: Consumer<ProjectsProvider>(
        builder: (context, projectsProvider, _) {
          final projects = projectsProvider.projects;

          if (projectsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (projects.isEmpty) {
            return EmptyStateWidget(
              title: 'Nenhum projeto',
              subtitle: 'Crie seu primeiro projeto para começar',
              icon: Icons.folder_outlined,
              action: ElevatedButton.icon(
                onPressed: _openProjectForm,
                icon: const Icon(Icons.add),
                label: const Text('Novo Projeto'),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => projectsProvider.loadProjects(),
            child: Consumer3<TasksProvider, DecisionsProvider, DiaryProvider>(
              builder: (context, tasksProvider, decisionsProvider, diaryProvider, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(AppDimen.lg),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];

                    // Calcula contadores direto dos providers
                    final projectTasks = tasksProvider.tasks
                        .where((t) => t.projectId == project.id)
                        .toList();
                    final completedTasks = projectTasks
                        .where((t) => t.completed)
                        .length;
                    final totalTasks = projectTasks.length;

                    final decisions = decisionsProvider.decisions
                        .where((d) => d.projectId == project.id)
                        .length;

                    final diaryEntries = diaryProvider.entries
                        .where((e) => e.projectId == project.id)
                        .length;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppDimen.lg),
                      child: ProjectCard(
                        project: project,
                        completedTasks: completedTasks,
                        totalTasks: totalTasks,
                        decisions: decisions,
                        diaryEntries: diaryEntries,
                        onTap: () => _openProjectDetail(project),
                        onDelete: () => _deleteProject(project),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openProjectForm,
        icon: const Icon(Icons.add),
        label: const Text('Novo Projeto'),
      ),
    );
  }

  void _openProjectForm() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ProjectFormScreen()));
  }

  void _openProjectDetail(Project project) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProjectDetailScreen(project: project)),
    );
  }

  Future<void> _deleteProject(Project project) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Projeto?'),
        content: Text('Você tem certeza que deseja deletar "${project.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await context.read<ProjectsProvider>().deleteProject(project.id);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Projeto deletado')));
      }
    }
  }
}
