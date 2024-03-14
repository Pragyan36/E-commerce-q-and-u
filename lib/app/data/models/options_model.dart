class Options {
  final int id;
  final String title;
  final String value;

  Options({required this.id, required this.title, required this.value});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      id: json['id'],
      title: json['title'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
    };
  }
}
