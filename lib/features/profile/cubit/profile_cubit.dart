import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/features/profile/cubit/states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getUserProfile() {
    emit(ProfileLoading());
    try {
      /*
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(ProfileLoaded(
          name: user.displayName ?? 'No Name Set',
          email: user.email ?? 'No Email',
        ));
      } else {
        emit(ProfileError(errorMessage: e.toString()));
      }
      */

      // mock data 
      emit(ProfileLoaded(
        name: 'hana Alaa', 
        email: 'hana@example.com',
      ));

    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }
}