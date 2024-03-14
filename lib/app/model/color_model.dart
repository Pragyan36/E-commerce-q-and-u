class ColorModel {
  int? colorId;
  int? indexId;
  String? title;
  int? value;

  ColorModel({
    this.colorId,
    this.indexId,
    this.title,
    this.value,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      colorId: json['color_id'],
      indexId: json['indexId'],
      title: json['title'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color_id': colorId,
      'indexId': indexId,
      'title': title,
      'value': value,
    };
  }
}

class ColorListModel {
  List<List<ColorModel>> data;

  ColorListModel({required this.data});

  factory ColorListModel.fromJson(List<List<Map<String, dynamic>>> json) {
    List<List<ColorModel>> parsedData = json.map((list) {
      return list.map((map) => ColorModel.fromJson(map)).toList();
    }).toList();

    return ColorListModel(data: parsedData);
  }

  List<List<Map<String, dynamic>>> toJson() {
    return data.map((list) => list.map((item) => item.toJson()).toList()).toList();
  }
}