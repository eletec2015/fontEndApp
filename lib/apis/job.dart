part of 'client.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: must_be_immutable

@JsonSerializable()
class Job extends Equatable {
  int id;
  String jobID;
  String date;
  String card;
  int unit;
  String remark;
  int order_id;

  static Job fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
  Map<String, dynamic> toJson() => _$JobToJson(this);

  @override
  List<Object> get props => [id, jobID, date, card, unit, remark, order_id];
}

@JsonSerializable()
class JobList extends Equatable {
  int totalCount;
  int pageNo;

  List<Job> data;

  static JobList fromJson(Map<String, dynamic> json) => _$JobListFromJson(json);
  Map<String, dynamic> toJson() => _$JobListToJson(this);

  @override
  List<Object> get props => [totalCount, pageNo];
}
