import 'package:get/get.dart';
import 'package:tiu/app/data/datasources/back4app/milestone/milestone_repository_exception.dart';
import 'package:tiu/app/domain/models/csv_model.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';
import 'package:tiu/app/domain/models/milestones_equals_calcs_model.dart';
import 'package:tiu/app/domain/models/milestones_equals_model.dart';
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

  final _milestoneOthersList = <MilestoneModel>[].obs;
  List<MilestoneModel> get milestonesOthers => _milestoneOthersList.toList();

  final _milestoneEquals = <MilestonesEqualsModel>[].obs;
  List<MilestonesEqualsModel> get milestoneEquals => _milestoneEquals.toList();

  final _milestone = Rxn<MilestoneModel>();
  MilestoneModel? get milestone => _milestone.value;

  final _csvList = <CsvModel>[].obs;
  List<CsvModel> get csvList => _csvList.toList();

  final _milestoneSearchList = <MilestoneModel>[].obs;
  List<MilestoneModel> get milestoneSearch => _milestoneSearchList.toList();

  String? fileString;

  @override
  void onInit() {
    String arg = Get.arguments;
    if (arg == 'myMilestones') {
      listMyMilestones();
    } else if (arg == 'OthersMilestones') {
      listOthersMilestones();
    } else if (arg == 'EqualsMilestones') {
      milestonesEquals();
    }
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> listMyMilestones() async {
    _milestoneList.clear();
    await _milestoneUseCase.list(_milestoneList, true);
  }

  Future<void> listOthersMilestones() async {
    _milestoneOthersList.clear();
    await _milestoneUseCase.list(_milestoneOthersList, false);
  }

  Future<void> milestonesEquals() async {
    try {
      await listMyMilestones();
      await listOthersMilestones();
      for (var my in milestones) {
        final milestonesEqualsModel = MilestonesEqualsModel(
            milestonesEquals: [my], milestonesEqualsCalcs: []);
        for (var others in milestonesOthers) {
          if (my.name == others.name) {
            milestonesEqualsModel.milestonesEquals.add(others);
            comparativeAnalysis(my, others, milestonesEqualsModel);
          }
        }
        if (milestonesEqualsModel.milestonesEquals.length > 1) {
          _milestoneEquals.add(milestonesEqualsModel);
        }
      }
      Get.toNamed(Routes.milestoneEqualsList);
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro em analise',
        message: 'Nao foi possivel analisar alguns dados',
        isError: true,
      );
    } finally {}
  }

  comparativeAnalysis(MilestoneModel my, MilestoneModel others,
      MilestonesEqualsModel milestonesEquals) {
    MilestonesEqualsCalcsModel milestonesEqualsCalcsModel =
        MilestonesEqualsCalcsModel(
            name: my.name, idMy: my.id!, idOther: others.id!);

    if (my.utmx != null && others.utmx != null) {
      if ((my.utmx! - others.utmx!).abs() > 0.5) {
        milestonesEqualsCalcsModel = milestonesEqualsCalcsModel.copyWith(
            utmx: (my.utmx! - others.utmx!));
      }
    }
    if (my.utmy != null && others.utmy != null) {
      if ((my.utmy! - others.utmy!).abs() > 0.5) {
        milestonesEqualsCalcsModel = milestonesEqualsCalcsModel.copyWith(
            utmy: (my.utmy! - others.utmy!));
      }
    }
    if (my.utmz != null && others.utmz != null) {
      if ((my.utmz! - others.utmz!).abs() > 0.5) {
        milestonesEqualsCalcsModel = milestonesEqualsCalcsModel.copyWith(
            utmz: (my.utmz! - others.utmz!));
      }
    }
    // https://www.pilotopolicial.com.br/calculando-distancias-e-direcoes-utilizando-coordenadas-geograficas/
    if (my.lat != null && others.lat != null) {
      milestonesEqualsCalcsModel =
          milestonesEqualsCalcsModel.copyWith(lat: (my.lat! - others.lat!));
    }
    if (my.long != null && others.long != null) {
      milestonesEqualsCalcsModel =
          milestonesEqualsCalcsModel.copyWith(long: (my.long! - others.long!));
    }
    if (my.utmfuso != null && others.utmfuso != null) {
      if (my.utmfuso != others.utmfuso) {
        milestonesEqualsCalcsModel = milestonesEqualsCalcsModel.copyWith(
            utmfuso: ('${my.utmfuso!} = ${others.utmfuso!}'));
      }
    }
    if (my.utmzone != null && others.utmzone != null) {
      if (my.utmzone != others.utmzone) {
        milestonesEqualsCalcsModel = milestonesEqualsCalcsModel.copyWith(
            utmzone: ('${my.utmzone!} = ${others.utmzone!}'));
      }
    }
    if (my.utmpole != null && others.utmpole != null) {
      if (my.utmpole != others.utmpole) {
        milestonesEqualsCalcsModel = milestonesEqualsCalcsModel.copyWith(
            utmpole: ('${my.utmpole!} = ${others.utmpole!}'));
      }
    }
    milestonesEquals.milestonesEqualsCalcs.add(milestonesEqualsCalcsModel);
  }

  void updateMyMilestoneWithOther(String myId, String otherId) async {
    MilestoneModel my =
        _milestoneList.firstWhere((element) => element.id == myId);
    MilestoneModel other =
        _milestoneOthersList.firstWhere((element) => element.id == otherId);
    MilestoneModel model = my.copyWith(
      utmx: other.utmx,
      utmy: other.utmy,
      utmz: other.utmz,
      utmfuso: other.utmfuso,
      utmzone: other.utmzone,
      utmpole: other.utmpole,
      lat: other.lat,
      long: other.long,
    );
    await _milestoneUseCase.update(model);
    Get.back();
  }

  Future<void> append({
    required String name,
    required double? utmx,
    required double? utmy,
    required double? utmz,
    required String? utmfuso,
    required String? utmzone,
    required String? utmpole,
    required double? lat,
    required double? long,
  }) async {
    try {
      _loading(true);
      MilestoneModel model;
      if (milestone == null) {
        SplashController splashController = Get.find();
        model = MilestoneModel(
          user: splashController.userModel!,
          name: name,
          utmx: utmx,
          utmy: utmy,
          utmz: utmz,
          utmfuso: utmfuso,
          utmzone: utmzone,
          utmpole: utmpole,
          lat: lat,
          long: long,
        );
        await _milestoneUseCase.create(model);
      } else {
        model = milestone!.copyWith(
          id: milestone!.id,
          name: name,
          utmx: utmx,
          utmy: utmy,
          utmz: utmz,
          utmfuso: utmfuso,
          utmzone: utmzone,
          utmpole: utmpole,
          lat: lat,
          long: long,
        );
        await _milestoneUseCase.update(model);
      }
    } on MilestoneRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      listMyMilestones();
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
      listMyMilestones();
      _loading(false);
    }
  }

  void add() {
    print('add');
    _milestone.value = null;
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
        utmy: double.tryParse(lineList[index[1]]),
        utmx: double.tryParse(lineList[index[2]]),
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

  onMilestoneSearch(String value, bool myMilestones) async {
    print('onMilestoneSearch $value');
    if (value.isEmpty) {
      _milestoneSearchList.clear();
    } else {
      _milestoneSearchList.clear();
      if (myMilestones) {
        _milestoneSearchList.addAll([
          ..._milestoneList.where((milestone) => milestone.name.contains(value))
        ]);
      } else {
        _milestoneSearchList.addAll([
          ..._milestoneOthersList
              .where((milestone) => milestone.name.contains(value))
        ]);
      }
    }
    print(_milestoneSearchList.length);
  }

  // offMilestoneSearch() {
  //   _milestoneSearchList.clear();
  // }
}
