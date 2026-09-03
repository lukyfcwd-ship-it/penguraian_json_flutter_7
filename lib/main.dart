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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown), // Tema disesuaikan dengan gambar Anda
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
        // Judul disesuaikan dengan instruksi tugas mandiri dan gambar Anda
        title: const Text('Daftar Pelanggan PT. [Andar]'), 
        backgroundColor: Colors.brown[700], // Menyamakan warna latar AppBar seperti gambar
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

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
                      backgroundColor: Colors.teal, // Warna avatar teal seperti pada gambar
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
                        Text('@${user.username}'),
                        // Menggunakan ikon bawaan agar tidak ada masalah rendering
                        Row(
                          children: [
                            const Icon(Icons.email_outlined, size: 16, color: Colors.blueAccent),
                            const SizedBox(width: 4),
                            Text(user.email),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 16, color: Colors.black54),
                            const SizedBox(width: 4),
                            Text(user.phone),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('Tidak ada data pengguna.'),
          );
        },
      ),
    );
  }
}