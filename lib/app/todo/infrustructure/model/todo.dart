class TodoModel {
  final List<TodoInfoModel> todos;
  final int total;
  final int limit;

  TodoModel({required this.limit, required this.todos, required this.total});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        limit: json["limit"],
        todos: (json["todos"] as List)
            .map((e) => TodoInfoModel.fromJson(e))
            .toList(),
        total: json["total"]);
  }
}

class TodoInfoModel {
  final int id;
  final String todo;
  bool completed;

  TodoInfoModel({
    required this.id,
    required this.todo,
    required this.completed,
  });

  factory TodoInfoModel.fromJson(Map<String, dynamic> json) {
    return TodoInfoModel(
        id: json["id"], todo: json["todo"], completed: json["completed"]);
  }

}
