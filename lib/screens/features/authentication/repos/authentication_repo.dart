import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Firebase를 호출하는 역할
class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGitHub() async {
    await FirebaseAuth.instance.signInWithProvider(GithubAuthProvider());
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

/// 유저의 인증 상태 변경 감지
final authStream = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
