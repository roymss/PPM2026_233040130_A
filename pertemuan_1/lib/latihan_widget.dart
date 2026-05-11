import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menghilangkan banner debug di pojok kanan atas
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // AppBar: Bagian atas aplikasi dengan judul
        appBar: AppBar(
          title: const Text("Hello Flutter"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        // Body: Konten utama aplikasi
        body: Center(
          // Center: Menempatkan widget di tengah layar
          child: Column(
            // Column: Menyusun widget secara vertikal
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Emoji atau Icon sebagai pembuka
              const Text(
                '👋',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 16), // Memberi jarak vertikal
              
              // 2. Teks Nama dengan Styling Bold
              const Text(
                'Halo, Hilmi', // Sesuai instruksi: Ganti dengan nama kamu
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              
              // 3. Teks Deskripsi
              const Text(
                'Selamat datang di dunia Flutter.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              
              // 4. Kartu Profil (Latihan 7.5 - Container)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32), // Jarak luar
                padding: const EdgeInsets.all(20), // Jarak dalam
                decoration: BoxDecoration(
                  color: Colors.blue.shade50, // Warna latar kartu
                  borderRadius: BorderRadius.circular(20), // Melengkungkan sudut
                  border: Border.all(color: Colors.blue.shade200), // Garis tepi
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                  children: [
                    const Text(
                      'NIM: 233040047', // Ganti dengan NIM kamu
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Prodi: Teknik Informatika',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Semester: 6',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // 5. Tombol Interaktif (Latihan 7.6)
              ElevatedButton(
                onPressed: () {
                  // Aksi tombol belum didefinisikan di materi
                },
                child: const Text("Tap Saya"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
