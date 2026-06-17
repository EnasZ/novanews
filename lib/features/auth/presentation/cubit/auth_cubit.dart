import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';
import '../../data/data_sources/auth_local_data_source.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthLocalDataSource localDataSource;

  AuthCubit(this.localDataSource) : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    final user = localDataSource.getUser(email);
    if (user != null && user.password == password) {
      await localDataSource.setLoggedUser(email);
      emit(AuthSuccess(user));
    } else {
      emit(const AuthError("Invalid email or password"));
    }
  }

  void register(UserModel user) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    final existingUser = localDataSource.getUser(user.email);
    if (existingUser != null) {
      emit(const AuthError("User already exists"));
    } else {
      await localDataSource.cacheUser(user);
      await localDataSource.setLoggedUser(user.email);
      emit(AuthSuccess(user));
    }
  }

  void logout() async {
    await localDataSource.clearUser();
    emit(AuthInitial());
  }
  
  void checkAuth() {
    final user = localDataSource.getLoggedUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthInitial());
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    emit(AuthLoading());
    final user = localDataSource.getLoggedUser();
    if (user != null && user.password == currentPassword) {
      final updatedUser = UserModel(
        fullName: user.fullName,
        email: user.email,
        password: newPassword,
        age: user.age,
        country: user.country,
      );
      await localDataSource.cacheUser(updatedUser);
      emit(AuthSuccess(updatedUser));
    } else {
      emit(const AuthError("Incorrect current password"));
    }
  }
}
