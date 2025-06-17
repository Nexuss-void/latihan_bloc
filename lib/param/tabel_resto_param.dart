class TableRestoParam {
  final int? id;
  final String? code;
  final String? name;
  final int? capacity;
  final String? table_status;
  final String? status;

  TableRestoParam(
      {this.id,
      this.code,
      this.name,
      this.capacity,
      this.table_status,
      this.status});

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name, 'capacity': capacity};
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'code': code,
      'name': name,
      'capacity': capacity,
      'table_status': table_status,
      'status': status,
    };
  }
}
