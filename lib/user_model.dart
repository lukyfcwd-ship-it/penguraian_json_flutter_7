class UserModel {
  final int id;
  final String name;
  final String username; // Letak Tugas 1: Menambahkan atribut username
  final String email;
  final String phone;    // Letak Tugas 1: Menambahkan atribut phone

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
  });

  // Letak Tugas 2: Menyesuaikan fromJson untuk membaca username dan phone
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // Letak Tugas 2: Menyesuaikan toJson untuk menyimpan username dan phone
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }
}