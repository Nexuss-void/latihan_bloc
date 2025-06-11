class TableRestoModel {
  final int? id;
  final String? code;
  final String? name;
  final int? capacity;
  final String? table_status;
  final String? status;

  TableRestoModel(
      {required this.id,
      required this.code,
      required this.name,
      required this.capacity,
      required this.table_status,
      required this.status});

  factory TableRestoModel.fromJson(Map<String, dynamic> json) {
    return TableRestoModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      capacity: json['capacity'],
      table_status: json['table_status'],
      status: json['status'],
    );
  }
}
