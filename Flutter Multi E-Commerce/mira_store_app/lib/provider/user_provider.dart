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

  //Method Recreate the user state
  void recreateUserState({
    required String state,
    required String city,
    required String locality,
  }) {
    if (this.state != null) {
      this.state = User(
        id: this.state!.id,
        fullName: this.state!.fullName,
        email: this.state!.email,
        state: state,
        city: city,
        password: this.state!.password,
        locality: locality,
        token: this.state!.token,
      );
    }
  }
}

//Make the data acisible withing the application
final userProvider = StateNotifierProvider<UserProvider, User?>(
  (ref) => UserProvider(),
);
