import 'package:flutter/material.dart';
import 'user_model.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Parsing JSON SMK RPL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<UserModel>> _futureUsers;

  @override
  void initState() {
    super.initState();
    // Memanggil API saat layar pertama kali dimuat
    _futureUsers = ApiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ==================================================================
        // LETAK TUGAS 5: Mengubah judul AppBar dan Warnanya
        // ==================================================================
        title: const Text('Daftar Pelanggan PT. [Andar]'),
        backgroundColor: Colors.brown, // Diubah menjadi coklat sesuai gambar Anda
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          // 1. Kondisi saat data masih dalam proses loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 2. Kondisi jika terjadi error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // 3. Kondisi jika data berhasil diambil dan tidak kosong
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<UserModel> users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                UserModel user = users[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal, // Warna avatar hijau-kebiruan (teal)
                      child: Text(
                        user.name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================================================================
                        // LETAK TUGAS 3: Menampilkan data username dan phone pada UI
                        // Menggunakan format asli modul (dengan teks/simbol, bukan ikon)
                        // ==================================================================
                        Text('@${user.username}'),
                        Text('✉ ${user.email}'),
                        Text('📞 ${user.phone}'),
                        // ==================================================================
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // 4. Kondisi jika data kosong
          return const Center(
            child: Text('Tidak ada data pengguna.'),
          );
        },
      ),
    );
  }
}