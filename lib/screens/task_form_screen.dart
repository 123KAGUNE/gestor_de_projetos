import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimen.dart';
import '../core/constants/app_text_styles.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class TaskFormScreen extends StatefulWidget {
  final String projectId;
  final Task? task;

  const TaskFormScreen({Key? key, required this.projectId, this.task})
    : super(key: key);

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late String _selectedPriority;
  DateTime? _selectedDueDate;

  final _priorities = ['low', 'medium', 'high'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    _selectedPriority = widget.task?.priority ?? 'medium';
    _selectedDueDate = widget.task?.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unselectedChipBg =
        isDark ? const Color(0xFF2A2A2A) : AppColors.grey100;
    final unselectedChipBorder =
        isDark ? const Color(0xFF3A3A3A) : AppColors.grey300;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Tarefa' : 'Nova Tarefa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimen.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
                hintText: 'Ex: Implementar autenticação',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimen.radiusMd),
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: AppDimen.lg),

            // Descrição
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                hintText: 'Descreva a tarefa com mais detalhes...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimen.radiusMd),
                ),
              ),
              maxLines: 4,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: AppDimen.lg),

            // Prioridade
            Text('Prioridade', style: AppTextStyles.headingSmall),
            const SizedBox(height: AppDimen.md),
            Row(
              children: _priorities.map((priority) {
                final isSelected = _selectedPriority == priority;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppDimen.sm),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPriority = priority),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimen.md,
                          horizontal: AppDimen.sm,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _getPriorityColor(priority).withOpacity(0.2)
                              : unselectedChipBg,
                          borderRadius: BorderRadius.circular(
                            AppDimen.radiusMd,
                          ),
                          border: Border.all(
                            color: isSelected
                                ? _getPriorityColor(priority)
                                : unselectedChipBorder,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _getPriorityLabel(priority),
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isSelected
                                  ? _getPriorityColor(priority)
                                  : (isDark
                                      ? colorScheme.onSurface
                                      : AppColors.grey600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: AppDimen.lg),

            // Data de Vencimento
            Text('Data de Vencimento', style: AppTextStyles.headingSmall),
            const SizedBox(height: AppDimen.md),
            GestureDetector(
              onTap: _selectDueDate,
              child: Container(
                padding: const EdgeInsets.all(AppDimen.md),
                decoration: BoxDecoration(
                  border: Border.all(color: unselectedChipBorder),
                  borderRadius: BorderRadius.circular(AppDimen.radiusMd),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDueDate != null
                          ? _formatDate(_selectedDueDate!)
                          : 'Selecione uma data',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _selectedDueDate != null
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimen.xxxl),

            // Botões
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: AppDimen.lg),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(isEditing ? 'Atualizar' : 'Criar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() => _selectedDueDate = pickedDate);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
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

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case 'high':
        return 'Alta';
      case 'medium':
        return 'Média';
      case 'low':
        return 'Baixa';
      default:
        return '';
    }
  }

  void _submit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o título da tarefa')),
      );
      return;
    }

    final tasksProvider = context.read<TasksProvider>();

    if (widget.task != null) {
      // Editar
      tasksProvider.updateTask(
        widget.task!.copyWith(
          title: title,
          description: description,
          priority: _selectedPriority,
          dueDate: _selectedDueDate,
        ),
      );
    } else {
      // Criar
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        projectId: widget.projectId,
        title: title,
        description: description,
        priority: _selectedPriority,
        dueDate: _selectedDueDate,
        completed: false,
        createdAt: DateTime.now(),
      );
      tasksProvider.addTask(newTask);
    }

    Navigator.pop(context);
  }
}
