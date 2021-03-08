import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';
//flutter pub run build_runner build

@JsonSerializable()
class Model{
  final int userId;
  final int id;
  final String title;
  final String body;

  Model({this.userId, this.id, this.title, this.body});

  factory Model.fromJson(Map<String, dynamic> json) =>
      _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}