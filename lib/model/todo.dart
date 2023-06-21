class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'TOMAR CAFÉ', isDone: true ),
      ToDo(id: '02', todoText: 'IR PARA ACADEMIA', isDone: true ),
      ToDo(id: '03', todoText: 'IR PARA A FACULDADE', ),
      ToDo(id: '04', todoText: 'IR PARA O TRABALHO', ),
      ToDo(id: '05', todoText: 'OLHAR O ROCKET', ),
      ToDo(id: '06', todoText: 'FAZER TRABALHOS DA FACULDADE', ),
    ];
  }
}