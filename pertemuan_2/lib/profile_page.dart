import 'package:flutter/material.dart';
import 'widget_gallery.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // soft color background
      appBar: AppBar(
        title: const Text("Profil saya"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Beranda"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profil"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Pengaturan"),
              onTap: () {
                Navigator.pop(context); // Close drawer
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Pengaturan"),
                    content: const Text("Halaman pengaturan sedang dalam pengembangan."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Tutup"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text("Widget Gallery"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WidgetGallery()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/144675765?v=4"), // GitHub avatar
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Hilmy",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Mahasiswa Teknik Informatika",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem("Post", "1"),
                        _buildStatItem("Followers", "2.4K"),
                        _buildStatItem("Following", "1"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // About Section
              const Text(
                "Tentang saya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Saya mahasiswa semester 6 yang tertarik pada Flutter dan pengembangan aplikasi mobile. Hobi saya koding dan mengeksplorasi teknologi baru.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              // Experience Section (previously Skills)
              const Text(
                "Pengalaman",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildSkillCard(
                title: "Mobile Development",
                icon: Icons.smartphone,
                description: "Flutter, Dart, Android Studio",
              ),
              _buildSkillCard(
                title: "Web Development",
                icon: Icons.web,
                description: "HTML, CSS, JavaScript, React",
              ),
              const SizedBox(height: 24),
              // New Section Card 5: Skills (Wrap with 5 Chips)
              const Text(
                "Skills",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: const [
                      Chip(label: Text("Flutter")),
                      Chip(label: Text("Dart")),
                      Chip(label: Text("Git")),
                      Chip(label: Text("UI/UX")),
                      Chip(label: Text("Firebase")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Edit profil belum tersedia")),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profil",
          ),
          NavigationDestination(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: "Pesan",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildSkillCard(
      {required String title,
      required IconData icon,
      required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
