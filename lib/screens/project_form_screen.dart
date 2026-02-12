import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_dimen.dart';
import '../core/constants/app_text_styles.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class ProjectFormScreen extends StatefulWidget {
  final Project? project;

  const ProjectFormScreen({Key? key, this.project}) : super(key: key);

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  String _selectedColor = '#3B82F6';

  final _colors = [
    '#3B82F6', // Azul
    '#10B981', // Verde
    '#F59E0B', // Âmbar
    '#EF4646', // Vermelho
    '#800080', // Roxo
    '#EC4899', // Rosa
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.project?.description ?? '',
    );
    _selectedColor = widget.project?.color ?? '#3B82F6';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.project != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Projeto' : 'Novo Projeto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimen.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome do projeto
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome do Projeto',
                hintText: 'Ex: App de Compras',
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
                hintText: 'Descreva o objetivo do projeto...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimen.radiusMd),
                ),
              ),
              maxLines: 3,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: AppDimen.lg),

            // Seleção de cor
            Text('Cor do Projeto', style: AppTextStyles.headingSmall),
            const SizedBox(height: AppDimen.md),
            Wrap(
              spacing: AppDimen.md,
              runSpacing: AppDimen.md,
              children: _colors.map((color) {
                final selected = _selectedColor == color;
                final borderColor = Theme.of(context).colorScheme.onSurface;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(
                        int.parse(
                          'ff${color.replaceFirst('#', '')}',
                          radix: 16,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(AppDimen.radiusLg),
                      border: Border.all(
                        color: borderColor,
                        width: selected ? 3 : 0,
                      ),
                    ),
                  ),
                );
              }).toList(),
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

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o nome do projeto')),
      );
      return;
    }

    final projectsProvider = context.read<ProjectsProvider>();

    if (widget.project != null) {
      // Editar
      await projectsProvider.updateProject(
        widget.project!.copyWith(
          name: name,
          description: description,
          color: _selectedColor,
        ),
      );
    } else {
      // Criar
      final newProject = Project(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        description: description,
        createdAt: DateTime.now(),
        color: _selectedColor,
      );
      await projectsProvider.addProject(newProject);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
