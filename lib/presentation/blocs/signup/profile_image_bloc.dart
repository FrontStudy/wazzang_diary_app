import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/member/image/image.dart';
import '../../../domain/usecases/signup/set_profile_image_usecase.dart';

abstract class ProfileImageState extends Equatable {}

class ProfileImageInitial extends ProfileImageState {
  @override
  List<Object?> get props => [];
}

class ProfileImageLoading extends ProfileImageState {
  @override
  List<Object?> get props => [];
}

class ProfileImageAdded extends ProfileImageState {
  final Image image;
  ProfileImageAdded(this.image);

  @override
  List<Object?> get props => [];
}

class ProfileImageFailed extends ProfileImageState {
  final Failure failure;
  ProfileImageFailed(this.failure);
  @override
  List<Object?> get props => [];
}

abstract class ProfileImageEvent {}

class SetProfileImage extends ProfileImageEvent {
  final SetProfileImageParams params;
  SetProfileImage(this.params);
}

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final SetProfileImageUseCase _setProfileImageUseCase;

  ProfileImageBloc(this._setProfileImageUseCase)
      : super(ProfileImageInitial()) {
    on<SetProfileImage>(_onSetProfileImage);
  }

  void _onSetProfileImage(
      SetProfileImage event, Emitter<ProfileImageState> emit) async {
    try {
      emit(ProfileImageLoading());
      final result = await _setProfileImageUseCase(event.params);
      result.fold((failure) => emit(ProfileImageFailed(failure)),
          (image) => emit(ProfileImageAdded(image)));
    } catch (e) {
      emit(ProfileImageFailed(ExceptionFailure()));
    }
  }
}
