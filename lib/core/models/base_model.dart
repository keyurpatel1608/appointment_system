abstract class BaseModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  BaseModel({this.id, this.createdAt, this.updatedAt});

  Map<String, dynamic> toJson();
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson not implemented for BaseModel');
  }
}