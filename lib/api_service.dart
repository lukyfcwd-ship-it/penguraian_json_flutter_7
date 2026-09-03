import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      
      List<UserModel> users = jsonList.map((item) {
        return UserModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      
      // ----------------------------------------------------
      // MENYISIPKAN DATA MANUAL KE URUTAN PALING ATAS
      // ----------------------------------------------------
      UserModel dataSaya = UserModel(
        id: 999, 
        name: 'Andar', // Sesuaikan dengan nama lengkap Anda
        username: 'andar_dev', // Sesuaikan dengan username Anda
        email: 'andar@email.com', // Sesuaikan dengan email Anda
        phone: '081234567890', // Sesuaikan dengan nomor telepon Anda
      );

      // Memasukkan data Anda ke index 0
      users.insert(0, dataSaya);
      // ----------------------------------------------------

      return users;
    } else {
      throw Exception('Gagal mengambil data dari server (Status: ${response.statusCode})');
    }
  }
}