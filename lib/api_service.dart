import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  // Function untuk mengambil daftar user dari API
  static Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // 1. Dekode response body String ke List<dynamic>
      List<dynamic> jsonList = jsonDecode(response.body);
      
      // 2. Mapping setiap elemen JSON ke dalam Objek UserModel
      List<UserModel> users = jsonList.map((item) {
        return UserModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      
      // ==================================================================
      // LETAK PENAMBAHAN DATA ANDA:
      // Kode di bawah ini menyisipkan data manual Anda di urutan teratas (index 0)
      // ==================================================================
      users.insert(0, UserModel(
        id: 999,
        name: 'Andar',
        username: 'andar', 
        email: 'andar@email.com',
        phone: '081234567890',
      ));
      // ==================================================================

      return users;
    } else {
      throw Exception('Gagal mengambil data dari server (Status: ${response.statusCode})');
    }
  }
}