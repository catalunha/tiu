import 'package:tiu/app/data/datasources/repositories/user_profile_repository.dart';
import 'package:tiu/app/domain/models/user_profile_model.dart';
import 'package:tiu/app/domain/usecases/user/profile/user_profile_usecase.dart';

class UserProfileUseCaseImpl implements UserProfileUseCase {
  final UserProfileRepository _userProfileRepository;
  UserProfileUseCaseImpl({required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository;

  @override
  Future<String> create(UserProfileModel userProfileModel) async {
    print(userProfileModel);
    return await _userProfileRepository.create(userProfileModel);
  }

  @override
  Future<String> update(UserProfileModel userProfileModel) async {
    print(userProfileModel);
    return await _userProfileRepository.update(userProfileModel);
  }
}
