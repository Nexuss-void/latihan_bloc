import 'dart:ffi';

class TableRestoCreate {
  final int? id;
  final String? code;
  final String? name;
  final int? capacity;
  final String? tableStatus;
  final String? status;

  factory TableRestoCreate.fromJson(Map<String, dynamic> json) {
    return TableRestoCreate(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        capacity: json["capacity"],
        tableStatus: json["table_status"],
        status: json["status"]);
  }

  TableRestoCreate(
      {required this.id,
      required this.code,
      required this.name,
      required this.capacity,
      required this.tableStatus,
      required this.status});
}
