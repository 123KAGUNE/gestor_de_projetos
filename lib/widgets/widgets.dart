import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimen.dart';
import '../core/constants/app_text_styles.dart';
import '../models/models.dart';

/// Card que mostra um projeto
class ProjectCard extends StatelessWidget {
  final Project project;
  final int completedTasks;
  final int totalTasks;
  final int decisions;
  final int diaryEntries;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const ProjectCard({
    Key? key,
    required this.project,
    this.completedTasks = 0,
    this.totalTasks = 0,
    this.decisions = 0,
    this.diaryEntries = 0,
    required this.onTap,
    this.onDelete,
  }) : super(key: key);

  Color _getColorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorFromHex(project.color);
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimen.radiusLg),
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [color, color.withOpacity(0.8)]
                  : [color.withOpacity(0.5), color.withOpacity(0.3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimen.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho com nome e menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name,
                            style: AppTextStyles.headingMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppDimen.xs),
                          Text(
                            project.description,
                            style: AppTextStyles.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (onDelete != null)
                      IconButton(
                        icon: const Icon(Icons.close, size: AppDimen.iconMd),
                        onPressed: onDelete,
                        splashRadius: 20,
                      ),
                  ],
                ),

                const SizedBox(height: AppDimen.md),

                // Barra de progresso
                if (totalTasks > 0) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimen.radiusSm),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: isDarkMode
                          ? AppColors.grey700
                          : AppColors.grey200,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                  const SizedBox(height: AppDimen.sm),
                  Text(
                    '$completedTasks/$totalTasks tarefas concluídas',
                    style: AppTextStyles.labelSmall,
                  ),
                  const SizedBox(height: AppDimen.md),
                ],

                // Estatísticas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatItem(
                      icon: Icons.task_outlined,
                      label: 'Tarefas',
                      value: totalTasks.toString(),
                    ),
                    _StatItem(
                      icon: Icons.check_circle_outlined,
                      label: 'Decisões',
                      value: decisions.toString(),
                    ),
                    _StatItem(
                      icon: Icons.notes_outlined,
                      label: 'Diário',
                      value: diaryEntries.toString(),
                    ),
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

/// Item de estatística para o ProjectCard
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, size: AppDimen.iconSm, color: colorScheme.onSurfaceVariant),
        const SizedBox(height: AppDimen.xs),
        Text(
          value,
          style: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Tile para mostrar uma tarefa
class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const TaskTile({
    Key? key,
    required this.task,
    this.onToggle,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  Color _getPriorityColor() {
    switch (task.priority.toLowerCase()) {
      case 'high':
        return AppColors.danger;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.grey400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimen.lg,
          vertical: AppDimen.md,
        ),
        leading: Checkbox(
          value: task.completed,
          onChanged: (_) => onToggle?.call(),
          activeColor: AppColors.primary,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: AppTextStyles.bodyMedium.copyWith(
                decoration: task.completed ? TextDecoration.lineThrough : null,
                color: task.completed
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onSurface,
              ),
            ),
            if (task.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  task.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppDimen.sm),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.sm,
                  vertical: AppDimen.xs,
                ),
                decoration: BoxDecoration(
                  color: _getPriorityColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimen.radiusSm),
                ),
                child: Text(
                  task.priority.toUpperCase(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: _getPriorityColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                onPressed: onDelete,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

/// Tile para mostrar uma decisão
class DecisionTile extends StatelessWidget {
  final Decision decision;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const DecisionTile({
    Key? key,
    required this.decision,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (decision.status.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'rejected':
        return AppColors.danger;
      case 'pending':
      default:
        return AppColors.warning;
    }
  }

  String _getStatusLabel() {
    switch (decision.status.toLowerCase()) {
      case 'approved':
        return 'Aprovada';
      case 'rejected':
        return 'Rejeitada';
      case 'pending':
      default:
        return 'Pendente';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimen.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    decision.title,
                    style: AppTextStyles.headingSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.danger,
                    ),
                    onPressed: onDelete,
                    splashRadius: 20,
                  ),
              ],
            ),
            const SizedBox(height: AppDimen.md),
            Text(
              decision.description,
              style: AppTextStyles.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimen.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.md,
                vertical: AppDimen.sm,
              ),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimen.radiusSm),
              ),
              child: Text(
                _getStatusLabel(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: _getStatusColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tile para mostrar uma entrada de diário
class DiaryEntryTile extends StatelessWidget {
  final DiaryEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const DiaryEntryTile({
    Key? key,
    required this.entry,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  String _getMoodEmoji() {
    switch (entry.mood.toLowerCase()) {
      case 'happy':
        return '😊';
      case 'sad':
        return '😢';
      case 'neutral':
      default:
        return '😐';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimen.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_getMoodEmoji(), style: const TextStyle(fontSize: 24)),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.danger,
                    ),
                    onPressed: onDelete,
                    splashRadius: 20,
                  ),
              ],
            ),
            const SizedBox(height: AppDimen.md),
            Text(
              entry.content,
              style: AppTextStyles.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimen.sm),
            Text(
              entry.createdAt.toString().split('.').first,
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget de estado vazio
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  const EmptyStateWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.grey300),
          const SizedBox(height: AppDimen.xl),
          Text(
            title,
            style: AppTextStyles.headingMedium,
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppDimen.md),
            Text(
              subtitle!,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[const SizedBox(height: AppDimen.xl), action!],
        ],
      ),
    );
  }
}
