import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tiu/app/data/datasources/back4app/entity/user_entity.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';

class MilestoneEntity {
  static const String className = 'Milestone';
  MilestoneModel fromParse(ParseObject parseObject) {
    MilestoneModel model = MilestoneModel(
      id: parseObject.objectId!,
      user: UserEntity().fromParse(parseObject.get('user') as ParseUser),
      name: parseObject.get('name'),
      utmx: parseObject.get('utmx'),
      utmy: parseObject.get('utmy'),
      utmz: parseObject.get('utmz'),
      utmfuso: parseObject.get('utmfuso'),
      utmzone: parseObject.get('utmzone'),
      utmpole: parseObject.get('utmpole'),
      lat: parseObject.get<ParseGeoPoint>('latlong')?.latitude,
      long: parseObject.get<ParseGeoPoint>('latlong')?.longitude,
    );
    return model;
  }

  Future<ParseObject> toParse(MilestoneModel model) async {
    final parseObject = ParseObject(MilestoneEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    parseObject.set('user', currentUser);
    parseObject.set('name', model.name);
    if (model.utmx != null) {
      parseObject.set('utmx', model.utmx);
    }
    if (model.utmy != null) {
      parseObject.set('utmy', model.utmy);
    }
    if (model.utmz != null) {
      parseObject.set('utmz', model.utmz);
    }
    if (model.utmfuso != null) {
      parseObject.set('utmfuso', model.utmfuso);
    }
    if (model.utmzone != null) {
      parseObject.set('utmzone', model.utmzone);
    }
    if (model.utmpole != null) {
      parseObject.set('utmpole', model.utmpole);
    }
    if (model.lat != null && model.long != null) {
      parseObject.set('latlong',
          ParseGeoPoint(latitude: model.lat!, longitude: model.long!));
    }
    return parseObject;
  }
}
