class AppUrl {
  AppUrl._();

  static const String baseUrl = "https://dummyjson.com";

  //**************** Todos **********************
  static const String  getTodos = "/todos";
  static const String addTodo = "/todos/add";
  static String editTodos(int id) => "/todos/$id";
  static String deleteTodos(int id) => "/todos/$id";


  //**************** AUTH **********************
  static const String login = "/auth/login";
  static const String myProfile = "/auth/me";
  static const String refreshToken = "/auth/refresh";

}
