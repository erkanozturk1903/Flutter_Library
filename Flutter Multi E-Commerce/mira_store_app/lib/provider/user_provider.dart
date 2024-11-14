import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mira_store_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider()
      : super(
          User(
            id: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            password: '',
            locality: '',
            token: '',
          ),
        );

  User? get user => state;

  //MEthod to set user state from Json
  // purpose : udates he user sate on json String respresantation of user Object

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  //Method to clear user state
  void signOut() {
    state = null;
  }
}

//Make the data acisible withing the application
final userProvider = StateNotifierProvider<UserProvider, User?>(
  (ref) => UserProvider(),
);
