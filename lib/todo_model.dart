class TodoModel {
  final int id;
  final String? title;
  final String description;
  bool isChacked;

  TodoModel(this.id,
      {this.title, this.description = '', this.isChacked = false});
}
