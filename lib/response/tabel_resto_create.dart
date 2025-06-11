class TableRestoCreate {
  final int? id;
  final String? code;
  final String? name;
  final int? capacity;
  final String? tablestatus;
  final int? status;

  TableRestoCreate(
      {required this.id,
      required this.code,
      required this.name,
      required this.capacity,
      required this.tablestatus,
      required this.status});

  factory TableRestoCreate.fromJson(Map<String, dynamic> json) {
    return TableRestoCreate(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        capacity: json["capacity"],
        tablestatus: json["tablestatus"],
        status: json["status"]);
  }
}
