import 'dart:convert';

/// Modelo de Projeto
class Project {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final String color; // Cor identificadora do projeto

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    this.color = '#3B82F6',
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    String? color,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'color': color,
  };

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      color: json['color'] as String? ?? '#3B82F6',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Modelo de Tarefa
class Task {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final bool completed;
  final DateTime? dueDate;
  final String priority; // 'low', 'medium', 'high'
  final DateTime createdAt;

  Task({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    this.completed = false,
    this.dueDate,
    this.priority = 'medium',
    required this.createdAt,
  });

  Task copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    bool? completed,
    DateTime? dueDate,
    String? priority,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'title': title,
    'description': description,
    'completed': completed,
    'dueDate': dueDate?.toIso8601String(),
    'priority': priority,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool? ?? false,
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
      priority: json['priority'] as String? ?? 'medium',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Modelo de Decisão
class Decision {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime createdAt;

  Decision({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    this.status = 'pending',
    required this.createdAt,
  });

  Decision copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    String? status,
    DateTime? createdAt,
  }) {
    return Decision(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'title': title,
    'description': description,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Decision.fromJson(Map<String, dynamic> json) {
    return Decision(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Decision && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Modelo de Entrada de Diário
class DiaryEntry {
  final String id;
  final String projectId;
  final String content;
  final String mood; // 'happy', 'neutral', 'sad'
  final DateTime createdAt;

  DiaryEntry({
    required this.id,
    required this.projectId,
    required this.content,
    this.mood = 'neutral',
    required this.createdAt,
  });

  DiaryEntry copyWith({
    String? id,
    String? projectId,
    String? content,
    String? mood,
    DateTime? createdAt,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'content': content,
    'mood': mood,
    'createdAt': createdAt.toIso8601String(),
  };

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      content: json['content'] as String,
      mood: json['mood'] as String? ?? 'neutral',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryEntry && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
