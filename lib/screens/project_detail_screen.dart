import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimen.dart';
import '../core/constants/app_text_styles.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailScreen({Key? key, required this.project})
    : super(key: key);

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tarefas'),
            Tab(text: 'Decisões'),
            Tab(text: 'Diário'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editProject(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteProject(context),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TasksTab(projectId: widget.project.id),
          _DecisionsTab(projectId: widget.project.id),
          _DiaryTab(projectId: widget.project.id),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem(context),
        child: _getFabIcon(),
      ),
    );
  }

  Icon _getFabIcon() {
    switch (_tabController.index) {
      case 0:
        return const Icon(Icons.task_alt);
      case 1:
        return const Icon(Icons.lightbulb);
      case 2:
        return const Icon(Icons.note_add);
      default:
        return const Icon(Icons.add);
    }
  }

  void _addItem(BuildContext context) {
    switch (_tabController.index) {
      case 0:
        Navigator.pushNamed(
          context,
          '/task-form',
          arguments: {'projectId': widget.project.id},
        );
        break;
      case 1:
        _showDecisionFormDialog(context);
        break;
      case 2:
        _showDiaryFormDialog(context);
        break;
    }
  }

  void _editProject(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/project-form',
      arguments: {'project': widget.project},
    );
  }

  void _deleteProject(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Projeto'),
        content: const Text('Tem certeza que deseja deletar este projeto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<ProjectsProvider>().deleteProject(widget.project.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  void _showDecisionFormDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova Decisão'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppDimen.md),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                final decision = Decision(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  projectId: widget.project.id,
                  title: title,
                  description: descriptionController.text.trim(),
                  status: 'pending',
                  createdAt: DateTime.now(),
                );
                context.read<DecisionsProvider>().addDecision(decision);
                Navigator.pop(context);
              }
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }

  void _showDiaryFormDialog(BuildContext context) {
    final contentController = TextEditingController();
    String selectedMood = 'neutral';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Nova Entrada de Diário'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Conteúdo',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: AppDimen.lg),
                Text('Humor', style: AppTextStyles.bodyMedium),
                const SizedBox(height: AppDimen.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _MoodButton(
                      emoji: '😊',
                      mood: 'happy',
                      isSelected: selectedMood == 'happy',
                      onTap: () => setState(() => selectedMood = 'happy'),
                    ),
                    _MoodButton(
                      emoji: '😐',
                      mood: 'neutral',
                      isSelected: selectedMood == 'neutral',
                      onTap: () => setState(() => selectedMood = 'neutral'),
                    ),
                    _MoodButton(
                      emoji: '😢',
                      mood: 'sad',
                      isSelected: selectedMood == 'sad',
                      onTap: () => setState(() => selectedMood = 'sad'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final content = contentController.text.trim();
                if (content.isNotEmpty) {
                  final entry = DiaryEntry(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    projectId: widget.project.id,
                    content: content,
                    mood: selectedMood,
                    createdAt: DateTime.now(),
                  );
                  context.read<DiaryProvider>().addEntry(entry);
                  Navigator.pop(context);
                }
              },
              child: const Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final String emoji;
  final String mood;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodButton({
    required this.emoji,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimen.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimen.radiusLg),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: AppDimen.xs),
            Text(mood, style: AppTextStyles.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _TasksTab extends StatelessWidget {
  final String projectId;

  const _TasksTab({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, tasksProvider, _) {
        final tasks = tasksProvider.tasks
            .where((t) => t.projectId == projectId)
            .toList();

        if (tasks.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.task_alt,
            title: 'Nenhuma tarefa',
            subtitle: 'Crie uma tarefa clicando no botão +',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(AppDimen.lg),
          itemCount: tasks.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppDimen.md),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskTile(
              task: task,
              onToggle: () {
                tasksProvider.toggleTask(task.id);
              },
              onDelete: () {
                tasksProvider.deleteTask(task.id);
              },
            );
          },
        );
      },
    );
  }
}

class _DecisionsTab extends StatelessWidget {
  final String projectId;

  const _DecisionsTab({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<DecisionsProvider>(
      builder: (context, decisionsProvider, _) {
        final decisions = decisionsProvider.decisions
            .where((d) => d.projectId == projectId)
            .toList();

        if (decisions.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.lightbulb,
            title: 'Nenhuma decisão',
            subtitle: 'Crie uma decisão clicando no botão +',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(AppDimen.lg),
          itemCount: decisions.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppDimen.md),
          itemBuilder: (context, index) {
            final decision = decisions[index];
            return DecisionTile(
              decision: decision,
              onDelete: () {
                decisionsProvider.deleteDecision(decision.id);
              },
            );
          },
        );
      },
    );
  }
}

class _DiaryTab extends StatelessWidget {
  final String projectId;

  const _DiaryTab({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryProvider>(
      builder: (context, diaryProvider, _) {
        final entries = diaryProvider.entries
            .where((e) => e.projectId == projectId)
            .toList();

        if (entries.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.note_outlined,
            title: 'Nenhuma entrada',
            subtitle: 'Crie uma entrada clicando no botão +',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(AppDimen.lg),
          itemCount: entries.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppDimen.md),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return DiaryEntryTile(
              entry: entry,
              onDelete: () {
                diaryProvider.deleteEntry(entry.id);
              },
            );
          },
        );
      },
    );
  }
}
