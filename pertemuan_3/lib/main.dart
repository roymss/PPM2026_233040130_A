import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// --- MODEL (Update: Tambah field email) ---
class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final String email; // Tugas 3: Email pengirim
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/tambah') {
          // Tugas 1: Bisa menerima argumen Catatan untuk Mode Edit
          final catatan = settings.arguments as Catatan?;
          return MaterialPageRoute(
            builder: (_) => TambahCatatanPage(catatanLama: catatan),
          );
        }
        if (settings.name == '/detail') {
          final catatan = settings.arguments as Catatan;
          return MaterialPageRoute(
            builder: (_) => DetailCatatanPage(catatan: catatan),
          );
        }
        return null;
      },
    );
  }
}

// --- HOME PAGE ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Catatan> _catatan = [
    Catatan(
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      email: 'mhs@unpas.ac.id',
      dibuatPada: DateTime.now(),
    ),
  ];

  // Tugas 2: State untuk Filter
  String _filterDipilih = 'Semua';
  final _opsiFilter = const ['Semua', 'Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');
    if (hasil is Catatan) {
      setState(() => _catatan.add(hasil));
    }
  }

  // Tugas 1: Fungsi untuk update data setelah Edit
  Future<void> _bukaDetail(Catatan c, int index) async {
    final hasil = await Navigator.pushNamed(context, '/detail', arguments: c);
    
    // Jika ada data balik (berarti di-edit), update list-nya
    if (hasil is Catatan) {
      setState(() {
        _catatan[index] = hasil;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tugas 2: Filter List berdasarkan kategori
    final listTampil = _filterDipilih == 'Semua'
        ? _catatan
        : _catatan.where((c) => c.kategori == _filterDipilih).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Tugas 2: Dropdown Filter di AppBar
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButton<String>(
              value: _filterDipilih,
              underline: const SizedBox(),
              items: _opsiFilter.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
              onChanged: (v) => setState(() => _filterDipilih = v!),
            ),
          ),
        ],
      ),
      body: listTampil.isEmpty
          ? const Center(child: Text('Tidak ada catatan.'))
          : ListView.builder(
              itemCount: listTampil.length,
              itemBuilder: (context, i) {
                final c = listTampil[i];
                // Cari index asli di list _catatan untuk update data
                final indexAsli = _catatan.indexOf(c);
                
                return ListTile(
                  title: Text(c.judul),
                  subtitle: Text("${c.kategori} - ${c.email}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => setState(() => _catatan.removeAt(indexAsli)),
                  ),
                  onTap: () => _bukaDetail(c, indexAsli),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// --- FORM PAGE (Update: Mode Edit & Validasi Email) ---
class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatanLama; // Tugas 1: Parameter Edit
  const TambahCatatanPage({super.key, this.catatanLama});

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulCtrl;
  late TextEditingController _isiCtrl;
  late TextEditingController _emailCtrl; // Tugas 3: Email Controller
  late String _kategori;

  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    // Tugas 1: Isi data jika mode Edit
    _judulCtrl = TextEditingController(text: widget.catatanLama?.judul ?? '');
    _isiCtrl = TextEditingController(text: widget.catatanLama?.isi ?? '');
    _emailCtrl = TextEditingController(text: widget.catatanLama?.email ?? '');
    _kategori = widget.catatanLama?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final catatan = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      email: _emailCtrl.text.trim(),
      dibuatPada: widget.catatanLama?.dibuatPada ?? DateTime.now(),
    );

    Navigator.pop(context, catatan);
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.catatanLama != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Catatan' : 'Tambah Catatan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judulCtrl,
              decoration: const InputDecoration(labelText: 'Judul', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            // Tugas 3: Field Email dengan Validasi Regex
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email Pengirim', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email wajib diisi';
                final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!regex.hasMatch(v)) return 'Format email tidak valid';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _kategori,
              decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
              items: _kategoriOpsi.map((k) => DropdownMenuItem(value: k, child: Text(k))).toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Isi', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: Icon(isEdit ? Icons.update : Icons.save),
              label: Text(isEdit ? 'Update Catatan' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- DETAIL PAGE (Update: Tombol Edit) ---
class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          // Tugas 1: Tombol Edit di Detail
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // Buka form dengan data yang sekarang
              final hasilEdit = await Navigator.pushNamed(context, '/tambah', arguments: catatan);
              if (hasilEdit is Catatan && context.mounted) {
                // Balikkan data baru ke HomePage
                Navigator.pop(context, hasilEdit);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(catatan.judul, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(catatan.kategori)),
                Chip(label: Text(catatan.email), avatar: const Icon(Icons.email, size: 16)),
              ],
            ),
            Text("Dibuat: ${catatan.dibuatPada.day}-${catatan.dibuatPada.month}-${catatan.dibuatPada.year}"),
            const Divider(height: 32),
            Text(catatan.isi, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
