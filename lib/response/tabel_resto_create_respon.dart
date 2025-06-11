import 'package:latihan_bloc_ti4malama/response/tabel_resto_create.dart';

class TabelRestoCreateResponse {
  final TableRestoCreate? tableRestoCreate;
  final String message;

  TabelRestoCreateResponse(
      {required this.tableRestoCreate, required this.message});

  factory TabelRestoCreateResponse.fromJson(Map<String, dynamic> json) {
    TableRestoCreate? tableRestoCreate;
    return TabelRestoCreateResponse(
        tableRestoCreate: json["data"] != null
            ? TableRestoCreate.fromJson(json['data'])
            : tableRestoCreate,
        message: json["message"]);
  }
}
