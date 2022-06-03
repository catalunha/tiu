import 'package:get/get.dart';
import 'package:tiu/app/data/datasources/repositories/milestone_repository.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';
import 'package:tiu/app/domain/usecases/milestone/milestone_usecase.dart';

class MilestoneUseCaseImpl implements MilestoneUseCase {
  final MilestoneRepository _repository;
  MilestoneUseCaseImpl({
    required MilestoneRepository repository,
  }) : _repository = repository;
  @override
  Future<void> create(MilestoneModel model) => _repository.create(model);

  @override
  Future<void> delete(String id) => _repository.delete(id);

  @override
  Future<void> list(RxList<MilestoneModel> list) => _repository.list(list);

  @override
  Future<void> update(MilestoneModel courseModel) =>
      _repository.update(courseModel);

  // @override
  // Future<void> updateAddress(String productId, String addressId) =>
  //     _repository.updateAddress(productId, addressId);

  // @override
  // void subscribe(
  //         {required RxList<ProductEntity> list, Pagination? pagination}) =>
  //     _repository.subscribe(list: list, pagination: pagination);
}
