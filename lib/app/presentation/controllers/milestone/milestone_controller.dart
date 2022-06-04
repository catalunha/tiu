import 'dart:io';

import 'package:get/get.dart';
import 'package:tiu/app/data/datasources/back4app/milestone/milestone_repository_exception.dart';
import 'package:tiu/app/domain/models/csv_model.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';
import 'package:tiu/app/domain/usecases/milestone/milestone_usecase.dart';
import 'package:tiu/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:tiu/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:tiu/app/presentation/controllers/utils/mixins/message_mixin.dart';
import 'package:tiu/app/routes.dart';

class MilestoneController extends GetxController
    with LoaderMixin, MessageMixin {
  final MilestoneUseCase _milestoneUseCase;
  MilestoneController({required MilestoneUseCase milestoneUseCase})
      : _milestoneUseCase = milestoneUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _milestoneList = <MilestoneModel>[].obs;
  List<MilestoneModel> get milestones => _milestoneList.toList();

  final _milestone = Rxn<MilestoneModel>();
  MilestoneModel? get milestone => _milestone.value;

  File? file;

  final _csvList = <CsvModel>[].obs;
  List<CsvModel> get csvList => _csvList.toList();

  String? fileString;

  @override
  void onInit() {
    list();
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> list() async {
    _milestoneList.clear();
    await _milestoneUseCase.list(_milestoneList);
  }

  Future<void> append({
    required String name,
  }) async {
    try {
      _loading(true);
      MilestoneModel model;
      String objectId;
      if (milestone == null) {
        SplashController splashController = Get.find();
        model = MilestoneModel(
          user: splashController.userModel!,
          name: name,
        );
        await _milestoneUseCase.create(model);
      } else {
        model = milestone!.copyWith(
          name: name,
        );
        await _milestoneUseCase.update(model);
      }
    } on MilestoneRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar o contato',
        isError: true,
      );
    } finally {
      list();
      _loading(false);
    }
  }

  Future<void> saveCloud({
    required String utmFuso,
    required String utmZona,
    required String utmPole,
  }) async {
    try {
      _loading(true);
      if (_csvList.isNotEmpty) {
        SplashController splashController = Get.find();
        for (var line in _csvList) {
          if (line.duplicated == null) {
            var model = MilestoneModel(
              user: splashController.userModel!,
              name: line.name!,
              utmx: line.utmx!,
              utmy: line.utmy!,
              utmz: line.utmz!,
              lat: line.lat!,
              long: line.long!,
              utmfuso: utmFuso,
              utmzone: utmZona,
              utmpole: utmPole,
            );
            await _milestoneUseCase.create(model);
          } else {
            var model = MilestoneModel(
              id: line.duplicated,
              user: splashController.userModel!,
              name: line.name!,
              utmx: line.utmx!,
              utmy: line.utmy!,
              utmz: line.utmz!,
              lat: line.lat!,
              long: line.long!,
              utmfuso: utmFuso,
              utmzone: utmZona,
              utmpole: utmPole,
            );
            await _milestoneUseCase.update(model);
          }
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      _loading(false);
      _message.value = MessageModel(
        title: 'Erro em salvar dados',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      list();
      _loading(false);
    }
  }

  void add() {
    _milestone(null);
    Get.toNamed(Routes.milestoneAppend);
  }

  void edit(String id) {
    print('milestoneCurrent: $id');
    var milestoneTemp = milestones.firstWhere((element) => element.id == id);
    _milestone(milestoneTemp);
    Get.toNamed(Routes.milestoneAppend);
  }

  Future<void> delete(String id) async {
    await _milestoneUseCase.delete(id);
    Get.back();
  }

  void deleteCsv(int id) async {
    _csvList.removeAt(id);
  }

  processFile() async {
    try {
      _loading(true);
      _csvList.clear();
      print('processFile');
      // var arq = file!.openRead();
      // var arqlines = await arq
      //     .transform(utf8.decoder)
      //     .transform(const LineSplitter())
      //     .toList();
      // // print(arqlines);
      if (fileString == null) {
        throw Exception();
      }
      var arqlines = fileString!.split('\n');
      String separator = delimiter(arqlines[0]);
      List<int> index = headerLine(
          arqlines[0], ['Name', 'Northing', 'Easting', 'Lat', 'Lon', 'EllHt']);

      // var index = firstLine(
      //     arqlines[0], ['Name', 'Northing', 'Easting', 'Lat', 'Lon', 'EllHt']);

      // secondLine(arqlines[1], separator, index);
      for (var i = 1; i < arqlines.length; i++) {
        nextLine(arqlines[i], separator, index);
        // print(line);
      }
      analyzeDuplicateMilestone();
    } catch (e) {
      _loading(false);
      _message.value = MessageModel(
        title: 'Erro no arquivo',
        message: 'Nao foi possivel ler os dados',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  nextLine(
    String line,
    String separator,
    List<int> index,
  ) {
    var lineList = line.split(separator);
    if (lineList.length == index.length) {
      // print(index);
      // print(lineList);
      CsvModel csvModel = CsvModel(
        name: lineList[index[0]],
        utmx: double.tryParse(lineList[index[1]]),
        utmy: double.tryParse(lineList[index[2]]),
        lat: double.tryParse(lineList[index[3]]),
        long: double.tryParse(lineList[index[4]]),
        utmz: double.tryParse(lineList[index[5]]),
      );
      print(csvModel);
      _csvList.add(csvModel);
      var readOrdered = <String>[];
      for (var i in index) {
        readOrdered.add(lineList[i]);
      }
      print(readOrdered);
    }
  }

  String delimiter(String line) {
    var lineList = line.split(' ');
    String deliminter = lineList[1];
    deliminter = deliminter.replaceAll('Delimiter', '');
    deliminter = deliminter.replaceAll('(', '');
    deliminter = deliminter.replaceAll(')', '');
    return deliminter;
  }

  List<int> headerLine(
    String line,
    List<String> myColums,
  ) {
    var lineList = line.split(' ');
    String header = lineList[2];
    header = header.replaceAll('FileFormat', '');
    header = header.replaceAll('(', '');
    header = header.replaceAll(')', '');
    var headers = header.split(',');
    var index = <int>[];
    for (var myCol in myColums) {
      index.add(headers.indexOf(myCol));
      // print(index);
    }
    return index;
  }

  analyzeDuplicateMilestone() {
    for (var milestone in milestones) {
      print(milestone.name);
      for (var i = 0; i < csvList.length; i++) {
        print(csvList[i].name);
        if (csvList[i].name == milestone.name) {
          _csvList.replaceRange(
              i, i + 1, [csvList[i].copyWith(duplicated: milestone.id)]);
        }
      }
    }
  }
}
