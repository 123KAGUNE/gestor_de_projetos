import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models.dart';

/// Serviço de armazenamento local usando SharedPreferences
class LocalStorage {
  static const String _projectsKey = 'projects';
  static const String _tasksKey = 'tasks';
  static const String _decisionsKey = 'decisions';
  static const String _diaryKey = 'diary';

  static late SharedPreferences _prefs;

  /// Inicializa o serviço de storage
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ============= PROJECTS =============

  /// Salva a lista de projetos
  static Future<void> saveProjects(List<Project> projects) async {
    final json = jsonEncode(projects.map((p) => p.toJson()).toList());
    await _prefs.setString(_projectsKey, json);
  }

  /// Carrega a lista de projetos
  static Future<List<Project>> getProjects() async {
    final json = _prefs.getString(_projectsKey);
    if (json == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((item) => Project.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // ============= TASKS =============

  /// Salva a lista de tarefas
  static Future<void> saveTasks(List<Task> tasks) async {
    final json = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await _prefs.setString(_tasksKey, json);
  }

  /// Carrega a lista de tarefas
  static Future<List<Task>> getTasks() async {
    final json = _prefs.getString(_tasksKey);
    if (json == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((item) => Task.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Carrega tarefas de um projeto específico
  static Future<List<Task>> getTasksByProject(String projectId) async {
    final tasks = await getTasks();
    return tasks.where((t) => t.projectId == projectId).toList();
  }

  // ============= DECISIONS =============

  /// Salva a lista de decisões
  static Future<void> saveDecisions(List<Decision> decisions) async {
    final json = jsonEncode(decisions.map((d) => d.toJson()).toList());
    await _prefs.setString(_decisionsKey, json);
  }

  /// Carrega a lista de decisões
  static Future<List<Decision>> getDecisions() async {
    final json = _prefs.getString(_decisionsKey);
    if (json == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((item) => Decision.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Carrega decisões de um projeto específico
  static Future<List<Decision>> getDecisionsByProject(String projectId) async {
    final decisions = await getDecisions();
    return decisions.where((d) => d.projectId == projectId).toList();
  }

  // ============= DIARY ENTRIES =============

  /// Salva a lista de entradas de diário
  static Future<void> saveDiaryEntries(List<DiaryEntry> entries) async {
    final json = jsonEncode(entries.map((e) => e.toJson()).toList());
    await _prefs.setString(_diaryKey, json);
  }

  /// Carrega a lista de entradas de diário
  static Future<List<DiaryEntry>> getDiaryEntries() async {
    final json = _prefs.getString(_diaryKey);
    if (json == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((item) => DiaryEntry.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Carrega entradas de diário de um projeto específico
  static Future<List<DiaryEntry>> getDiaryEntriesByProject(
    String projectId,
  ) async {
    final entries = await getDiaryEntries();
    return entries.where((e) => e.projectId == projectId).toList();
  }

  // ============= CLEAR =============

  /// Limpa todo o armazenamento
  static Future<void> clearAll() async {
    await _prefs.clear();
  }

  /// Limpa dados de um projeto (para quando deletar um projeto)
  static Future<void> clearProject(String projectId) async {
    // Remove tarefas
    final tasks = await getTasks();
    tasks.removeWhere((t) => t.projectId == projectId);
    await saveTasks(tasks);

    // Remove decisões
    final decisions = await getDecisions();
    decisions.removeWhere((d) => d.projectId == projectId);
    await saveDecisions(decisions);

    // Remove entradas de diário
    final entries = await getDiaryEntries();
    entries.removeWhere((e) => e.projectId == projectId);
    await saveDiaryEntries(entries);
  }
}
