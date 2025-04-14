import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/errors/failures.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final SignOut signOut;
  final AuthRepository authRepository;

  AuthCubit({
    required this.signIn,
    required this.signUp,
    required this.signOut,
    required this.authRepository,
  }) : super(AuthInitial()) {
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    final result = await authRepository.getCurrentUser();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) {
        if (user != null && user.role != null) {
          emit(AuthAuthenticated(user));
        }
      },
    );
  }

  Future<void> addUser(String email, String role) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: 'defaultPassword123', // Handle password securely
      );

      // Add user to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role,
      });

      emit(AuthAuthenticated(userCredential.user!)); // Update state as needed
    } catch (e) {
      emit(AuthError('Failed to add user: ${e.toString()}'));
    }
  }
}
