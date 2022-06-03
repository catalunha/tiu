import 'package:tiu/app/data/datasources/back4app/entity/user_profile_entity.dart';
import 'package:tiu/app/data/datasources/back4app/user/profile/user_profile_repository_exception.dart';
import 'package:tiu/app/data/datasources/repositories/user_profile_repository.dart';
import 'package:tiu/app/domain/models/user_profile_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserProfileRepositoryB4a implements UserProfileRepository {
  @override
  Future<String> create(UserProfileModel userProfileModel) async {
    print('userProfile Repo create');
    print(userProfileModel);

    final userProfileParse =
        await UserProfileEntity().toParse(userProfileModel);
    print(userProfileParse);
    final ParseResponse responseUserProfile = await userProfileParse.save();
    if (responseUserProfile.success && responseUserProfile.results != null) {
      ParseObject userProfile =
          responseUserProfile.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      throw UserProfileRepositoryException(
          code: '000', message: 'Não foi possivel fazer update');
    }
  }

  @override
  Future<String> update(UserProfileModel userProfileModel) async {
    print('UserProfileRepositoryB4a.update');
    print(userProfileModel);
    final userProfileParse =
        await UserProfileEntity().toParse(userProfileModel);
    print(userProfileParse);

    final ParseResponse responseUserProfile = await userProfileParse.save();
    if (responseUserProfile.success && responseUserProfile.results != null) {
      ParseObject userProfile =
          responseUserProfile.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      throw UserProfileRepositoryException(
          code: '000', message: 'Não foi possivel fazer update');
    }
  }
}
