import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  final String id;
  final String? email;
  final String? role;

  const User({required this.id, this.email, this.role});

  factory User.fromFirebaseUser(firebase_auth.User user) {
    return User(id: user.uid, email: user.email);
  }

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      id: data['id'] ?? '',
      email: data['email'],
      role: data['role'],
    );
  }
}
