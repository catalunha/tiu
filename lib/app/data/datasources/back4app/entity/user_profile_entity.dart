import 'package:tiu/app/domain/models/user_profile_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserProfileEntity {
  static const String className = 'UserProfile';

  UserProfileModel fromParse(ParseObject parseObject) {
    UserProfileModel userProfileEntity = UserProfileModel(
      id: parseObject.objectId!,
      fullName: parseObject.get('fullName'),
      nickname: parseObject.get('nickname'),
      description: parseObject.get('description'),
      phone: parseObject.get('phone'),
      photo: parseObject.get('photo')?.get('url'),

      // photo: parseObject.get('photo') != null
      //     ? parseObject.get('photo')?.get('url')
      //     : null,
      email: parseObject.get('email'),
      sector: parseObject.get('sector'),
      position: parseObject.get('position'),
      activity: parseObject.get('activity'),
    );
    // userProfileEntity.photoParseFileBase = kIsWeb
    //     ? parseObject.get('photo') as ParseWebFile
    //     : parseObject.get('photo') as ParseFile;
    return userProfileEntity;
  }

  Future<ParseObject> toParse(UserProfileModel userProfileModel) async {
    final profileParse = ParseObject(UserProfileEntity.className);
    if (userProfileModel.id != null) {
      profileParse.objectId = userProfileModel.id;
    }
    if (userProfileModel.fullName != null) {
      profileParse.set('fullName', userProfileModel.fullName);
    }

    // if (fullName == null) {
    //   profileParse.unset('fullName');
    // } else {
    //   profileParse.set('fullName', fullName);
    // }
    if (userProfileModel.nickname != null) {
      profileParse.set('nickname', userProfileModel.nickname);
    }
    if (userProfileModel.description != null) {
      profileParse.set('description', userProfileModel.description);
    }
    if (userProfileModel.phone != null) {
      profileParse.set('phone', userProfileModel.phone);
    }
    // if (userProfileModel.photoParseFileBase != null) {
    //   profileParse.set('photo', userProfileModel.photoParseFileBase);
    // }
    if (userProfileModel.email != null) {
      profileParse.set('email', userProfileModel.email);
    }
    if (userProfileModel.sector != null) {
      profileParse.set('sector', userProfileModel.sector);
    }
    if (userProfileModel.position != null) {
      profileParse.set('position', userProfileModel.position);
    }
    if (userProfileModel.activity != null) {
      profileParse.set('activity', userProfileModel.activity);
    }
    return profileParse;
  }
}
