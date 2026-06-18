import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Catatan {
  final int? id;
  final String judul;
  final String isi;
  final String kategori;
  final DateTime dibuatPada;

  Catatan({
    this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.dibuatPada,
  });

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'judul': judul,
    'isi': isi,
    'kategori': kategori,
    'dibuat_pada': dibuatPada.toUtc().toIso8601String(),
  };

  static Catatan fromJson(Map<String, dynamic> m) => Catatan(
    id: m['id'] as int?,
    judul: m['judul'] as String,
    isi: m['isi'] as String,
    kategori: m['kategori'] as String,
    dibuatPada: DateTime.parse(m['dibuat_pada'] as String),
  );

  Catatan copyWith({String? judul, String? isi, String? kategori}) =>
      Catatan(
        id: id,
        judul: judul ?? this.judul,
        isi: isi ?? this.isi,
        kategori: kategori ?? this.kategori,
        dibuatPada: dibuatPada,
      );
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);
  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  // === Base URL & API key (lihat kontrak API di Langkah 0) ===
  static const String _baseUrl = 'https://besab-production.up.railway.app/api';
  static const String _apiKey  = '8f38b5fbf0bc437285f2c62ed6e447eab56f78c8f95239a7';
  // ==========================================================

  static const _timeout = Duration(seconds: 10);

  Map<String, String> get _headers => {
    'X-API-Key': _apiKey,
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ===== CRUD =====

  Future<List<Catatan>> getAll() async {
    final res = await _send(() => http.get(
      Uri.parse('$_baseUrl/catatan'),
      headers: _headers,
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (body['data'] as List).cast<Map<String, dynamic>>();
    return list.map(Catatan.fromJson).toList();
  }

  Future<Catatan> getById(int id) async {
    final res = await _send(() => http.get(
      Uri.parse('$_baseUrl/catatan/$id'),
      headers: _headers,
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<Catatan> insert(Catatan c) async {
    final res = await _send(() => http.post(
      Uri.parse('$_baseUrl/catatan'),
      headers: _headers,
      body: jsonEncode(c.toJson()),
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<Catatan> update(Catatan c) async {
    assert(c.id != null);
    final res = await _send(() => http.put(
      Uri.parse('$_baseUrl/catatan/${c.id}'),
      headers: _headers,
      body: jsonEncode(c.toJson()),
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _send(() => http.delete(
      Uri.parse('$_baseUrl/catatan/$id'),
      headers: _headers,
    ));
  }

  // ===== Helper: kirim + tangani 3 kelas error =====
  Future<http.Response> _send(Future<http.Response> Function() req) async {
    try {
      final res = await req().timeout(_timeout);
      if (res.statusCode >= 200 && res.statusCode < 300) return res;
      throw ApiException(res.statusCode, _extractMessage(res));
    } on SocketException {
      throw ApiException(0, 'Tidak ada koneksi internet.');
    } on TimeoutException {
      throw ApiException(0, 'Server tidak merespons (timeout).');
    }
  }

  String _extractMessage(http.Response res) {
    try {
      final m = jsonDecode(res.body) as Map<String, dynamic>;
      return (m['message'] as String?) ?? 'HTTP ${res.statusCode}';
    } catch (_) {
      return 'HTTP ${res.statusCode}';
    }
  }
}
