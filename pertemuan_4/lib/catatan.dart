class Catatan {
  final int? id;
  final String judul;
  final String isi;
  final int kategori;
  final DateTime dibuatPada;

  Catatan({
    this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.dibuatPada,
  });

  // Untuk SQL -> Map
  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'judul': judul,
        'isi': isi,
        'kategori': kategori,
        'dibuat_pada': dibuatPada.toIso8601String(),
      };

  // Dari Map -> Object
  factory Catatan.fromMap(Map<String, dynamic> map) => Catatan(
        id: map['id'] as int?,
        judul: map['judul'] as String,
        isi: map['isi'] as String,
        kategori: map['kategori'] as int,
        dibuatPada: DateTime.parse(map['dibuat_pada'] as String),
      );

  // Helper untuk edit = copy dengan beberapa field diganti
  Catatan copyWith({
    String? judul,
    String? isi,
    int? kategori,
    DateTime? dibuatPada,
  }) =>
      Catatan(
        id: id,
        judul: judul ?? this.judul,
        isi: isi ?? this.isi,
        kategori: kategori ?? this.kategori,
        dibuatPada: dibuatPada ?? this.dibuatPada,
      );
}
