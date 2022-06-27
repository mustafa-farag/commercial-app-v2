import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase{
  Future<User?> loginWithEmailAndPassword(String email,String password);
  Future<User?> registerWithEmailAndPassword(String email,String password);
  User? get currentUser;
  Stream<User?> authStateChanges();
}

class Auth implements AuthBase{
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userAuth = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userAuth.user;
  }

  @override
  Future<User?> registerWithEmailAndPassword(String email, String password) async{
    final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userAuth.user;
  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();


  @override
  User? get currentUser => _firebaseAuth.currentUser;

}