import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseAuth? userInstance = null;

  UserAuthRepository() {
    userInstance = _auth;
  }

  FirebaseAuth getInstance() {
    return _auth;
  }

  bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<bool> signInWithEmail(email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(_auth.currentUser!.uid);
      // TODO: Add user to database
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    }
    return false;
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);

    final user = authResult.user;

    if (user != null) {
      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);

      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.length == 0) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'id': user.uid,
          'username': user.displayName,
          'profilePicture': user.photoURL,
          'email': user.email,
          'pet_distance': 0,
          'statistics': {
            'food_level': 0,
            'water_level': 0,
            'history': {
              'food': [0, 0, 0, 0, 0, 0],
              'water': [0, 0, 0, 0, 0, 0],
            }
          }
        });

        // Create automations document
        FirebaseFirestore.instance.collection('automations').add({
          'useruid': user.uid,
          'alarms': [],
          'settings': [
            {
              'name': 'Eating',
              'value': false,
            },
            {
              'name': 'Drinking',
              'value': false,
            },
            {
              'name': 'Make sound to eat',
              'value': false,
            },
          ],
        });

        // Create actions document
        FirebaseFirestore.instance.collection('actions').add({
          'useruid': user.uid,
          'food': false,
          'water': false,
          'sound': false,
        });
      }
    } else {
      throw Exception('Error signing in with Google');
    }
  }
}
