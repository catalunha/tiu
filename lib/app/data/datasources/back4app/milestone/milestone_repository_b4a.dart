import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tiu/app/data/datasources/back4app/entity/milestone_entity.dart';
import 'package:tiu/app/data/datasources/repositories/milestone_repository.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';

class MilestoneRepositoryB4a extends GetxService
    implements MilestoneRepository {
  Future<QueryBuilder<ParseObject>> getQuery(bool myMilestones) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(MilestoneEntity.className));
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    if (myMilestones) {
      query.whereEqualTo('user', currentUser);
    } else {
      query.whereNotEqualTo('user', currentUser);
    }
    // if (pagination != null) {
    //   queryProduct.setAmountToSkip((pagination.page - 1) * pagination.limit);
    //   queryProduct.setLimit(pagination.limit);
    // }
    // queryProduct.keysToReturn([
    //   'code',
    //   'name',
    //   'image',
    //   'description',
    //   'price',
    //   'isAvaliable',
    //   'menuIsOpen',
    // ]);
    // queryProduct.selectKeys('name', 'Ana');
    query.orderByAscending('name');
    query.includeObject(['user', 'user.profile']);
    return query;
  }

  @override
  Future<void> list(RxList<MilestoneModel> list, bool myMilestones) async {
    final query = await getQuery(myMilestones);

    final ParseResponse response = await query.query();
    if (response.success && response.results != null) {
      list.clear();
      for (var element in response.results!) {
        print((element as ParseObject).objectId);
        list.add(MilestoneEntity().fromParse(element));
      }
    } else {
      print('Sem Milestones...');
    }
  }

  @override
  Future<void> create(MilestoneModel model) async {
    final parseObject = await MilestoneEntity().toParse(model);
    await parseObject.save();
  }

  @override
  Future<void> update(MilestoneModel model) async {
    final parseObject = await MilestoneEntity().toParse(model);
    await parseObject.save();
  }

  @override
  Future<void> delete(String id) async {
    var parseObject = ParseObject(MilestoneEntity.className)..objectId = id;
    await parseObject.delete();
  }
}
