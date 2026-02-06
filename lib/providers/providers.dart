import 'package:flutter/foundation.dart';
import '../../core/storage/local_storage.dart';
import '../../models/models.dart';

export 'theme_provider.dart';

/// Provider para gerenciar projetos
class ProjectsProvider extends ChangeNotifier {
  List<Project> _projects = [];
  bool _isLoading = false;
  String? _error;

  List<Project> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carrega todos os projetos do storage
  Future<void> loadProjects() async {
    _setLoading(true);
    try {
      _projects = await LocalStorage.getProjects();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar projetos: $e';
    }
    _setLoading(false);
  }

  /// Adiciona um novo projeto
  Future<void> addProject(Project project) async {
    _projects.add(project);
    await LocalStorage.saveProjects(_projects);
    notifyListeners();
  }

  /// Atualiza um projeto existente
  Future<void> updateProject(Project project) async {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
      await LocalStorage.saveProjects(_projects);
      notifyListeners();
    }
  }

  /// Deleta um projeto
  Future<void> deleteProject(String projectId) async {
    _projects.removeWhere((p) => p.id == projectId);
    await LocalStorage.saveProjects(_projects);
    await LocalStorage.clearProject(projectId);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

/// Provider para gerenciar tarefas
class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carrega todas as tarefas do storage
  Future<void> loadTasks() async {
    _setLoading(true);
    try {
      _tasks = await LocalStorage.getTasks();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar tarefas: $e';
    }
    _setLoading(false);
  }

  /// Carrega tarefas de um projeto específico
  Future<List<Task>> loadTasksByProject(String projectId) async {
    try {
      return await LocalStorage.getTasksByProject(projectId);
    } catch (e) {
      _error = 'Erro ao carregar tarefas: $e';
      return [];
    }
  }

  /// Adiciona uma nova tarefa
  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await LocalStorage.saveTasks(_tasks);
    notifyListeners();
  }

  /// Atualiza uma tarefa existente
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      await LocalStorage.saveTasks(_tasks);
      notifyListeners();
    }
  }

  /// Marca uma tarefa como completa/incompleta
  Future<void> toggleTask(String taskId) async {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = task.copyWith(completed: !task.completed);
      await LocalStorage.saveTasks(_tasks);
      notifyListeners();
    }
  }

  /// Deleta uma tarefa
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((t) => t.id == taskId);
    await LocalStorage.saveTasks(_tasks);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

/// Provider para gerenciar decisões
class DecisionsProvider extends ChangeNotifier {
  List<Decision> _decisions = [];
  bool _isLoading = false;
  String? _error;

  List<Decision> get decisions => _decisions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carrega todas as decisões do storage
  Future<void> loadDecisions() async {
    _setLoading(true);
    try {
      _decisions = await LocalStorage.getDecisions();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar decisões: $e';
    }
    _setLoading(false);
  }

  /// Carrega decisões de um projeto específico
  Future<List<Decision>> loadDecisionsByProject(String projectId) async {
    try {
      return await LocalStorage.getDecisionsByProject(projectId);
    } catch (e) {
      _error = 'Erro ao carregar decisões: $e';
      return [];
    }
  }

  /// Adiciona uma nova decisão
  Future<void> addDecision(Decision decision) async {
    _decisions.add(decision);
    await LocalStorage.saveDecisions(_decisions);
    notifyListeners();
  }

  /// Atualiza uma decisão existente
  Future<void> updateDecision(Decision decision) async {
    final index = _decisions.indexWhere((d) => d.id == decision.id);
    if (index != -1) {
      _decisions[index] = decision;
      await LocalStorage.saveDecisions(_decisions);
      notifyListeners();
    }
  }

  /// Deleta uma decisão
  Future<void> deleteDecision(String decisionId) async {
    _decisions.removeWhere((d) => d.id == decisionId);
    await LocalStorage.saveDecisions(_decisions);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

/// Provider para gerenciar entradas de diário
class DiaryProvider extends ChangeNotifier {
  List<DiaryEntry> _entries = [];
  bool _isLoading = false;
  String? _error;

  List<DiaryEntry> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carrega todas as entradas de diário do storage
  Future<void> loadDiaryEntries() async {
    _setLoading(true);
    try {
      _entries = await LocalStorage.getDiaryEntries();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar diário: $e';
    }
    _setLoading(false);
  }

  /// Carrega entradas de diário de um projeto específico
  Future<List<DiaryEntry>> loadDiaryEntriesByProject(String projectId) async {
    try {
      return await LocalStorage.getDiaryEntriesByProject(projectId);
    } catch (e) {
      _error = 'Erro ao carregar diário: $e';
      return [];
    }
  }

  /// Adiciona uma nova entrada de diário
  Future<void> addEntry(DiaryEntry entry) async {
    _entries.add(entry);
    await LocalStorage.saveDiaryEntries(_entries);
    notifyListeners();
  }

  /// Atualiza uma entrada de diário existente
  Future<void> updateEntry(DiaryEntry entry) async {
    final index = _entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      _entries[index] = entry;
      await LocalStorage.saveDiaryEntries(_entries);
      notifyListeners();
    }
  }

  /// Deleta uma entrada de diário
  Future<void> deleteEntry(String entryId) async {
    _entries.removeWhere((e) => e.id == entryId);
    await LocalStorage.saveDiaryEntries(_entries);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
