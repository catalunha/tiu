import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/domain/models/csv_model.dart';
import 'package:tiu/app/domain/utils/enums.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';
import 'package:tiu/app/presentation/views/milestone/append/parts/file_data_button.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/presentation/views/utils/app_launch.dart';

class MilestoneReadFilePage extends StatefulWidget {
  final MilestoneController _milestoneController = Get.find();

  MilestoneReadFilePage({Key? key}) : super(key: key);

  @override
  State<MilestoneReadFilePage> createState() => _MilestoneReadFilePageState();
}

class _MilestoneReadFilePageState extends State<MilestoneReadFilePage> {
  UtmFuso utmFuso = UtmFuso.fuso23;
  UtmZona utmZona = UtmZona.zonaX;
  UtmPole utmPole = UtmPole.sul;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: const Text('Selecionar, analisar e salvar'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FileDataButton(),
              ElevatedButton(
                onPressed: () {
                  widget._milestoneController.processFile();
                },
                child: const Text('Importar e analisar.'),
              ),
              Obx(
                () => Table(
                  border: TableBorder.all(),
                  children: buildRow(),
                  columnWidths: const {
                    0: FractionColumnWidth(0.07),
                    5: FractionColumnWidth(0.08),
                    6: FractionColumnWidth(0.08),
                    7: FractionColumnWidth(0.08),
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dropDownFuso(
                    title: 'Fuso',
                    options: UtmFuso.values,
                    variable: utmFuso,
                    faz: (value) {
                      utmFuso = value;
                    },
                  ),
                  dropDownZona(
                    title: 'Zona',
                    options: UtmZona.values,
                    variable: utmZona,
                    faz: (value) {
                      utmZona = value;
                    },
                  ),
                  dropDownPolo(
                    title: 'Polo',
                    options: UtmPole.values,
                    variable: utmPole,
                    faz: (value) {
                      utmPole = value;
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  await widget._milestoneController.saveCloud(
                    utmFuso: utmFuso.name,
                    utmZona: utmZona.name,
                    utmPole: utmPole.name,
                  );
                  Get.back();
                },
                child: const Text('Salvar na nuvem'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildRow() {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      header('#'),
      header('Name'),
      header('UTM'),
      header('Geog.'),
      header('Elev.'),
      header('Sts.'),
      header('Loc.'),
      header('Del.'),
    ]));
    for (var i = 0; i < widget._milestoneController.csvList.length; i++) {
      CsvModel csvModel = widget._milestoneController.csvList[i];
      rows.add(
        TableRow(
          children: [
            line(i + 1),
            line(csvModel.name),
            line('${csvModel.utmx}\n${csvModel.utmy}'),
            line('${csvModel.lat}\n${csvModel.long}'),
            line(csvModel.utmz),
            csvModel.duplicated == null
                ? const Icon(Icons.add)
                : const Icon(Icons.copy_outlined),
            InkWell(
              onTap: () =>
                  AppLaunch.launchGoogleMaps(csvModel.lat!, csvModel.long!),
              child: const Icon(Icons.location_on),
            ),
            InkWell(
              onTap: () {
                widget._milestoneController.deleteCsv(i);
              },
              child: const Icon(Icons.delete_forever),
            ),
          ],
        ),
      );
    }
    return rows;
  }

  Widget line(dynamic value) => Center(
          child: Text(
        '$value',
        style: const TextStyle(fontSize: 10.0),
      ));

  Widget header(String value) {
    return Center(
      child: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Column dropDownPolo({
    required String title,
    bool enabled = true,
    required List<UtmPole> options,
    required UtmPole variable,
    required Function(UtmPole) faz,
  }) {
    return Column(
      children: [
        Text(title),
        enabled
            ? Container(
                height: 30,
                width: 70,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: Center(
                  child: DropdownButton<UtmPole>(
                    value: variable,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (UtmPole? newValue) {
                      faz(newValue as UtmPole);
                      setState(() {});
                    },
                    items:
                        options.map<DropdownMenuItem<UtmPole>>((UtmPole value) {
                      return DropdownMenuItem<UtmPole>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox(width: 50, height: 60),
      ],
    );
  }

  Column dropDownFuso({
    required String title,
    bool enabled = true,
    required List<UtmFuso> options,
    required UtmFuso variable,
    required Function(UtmFuso) faz,
  }) {
    return Column(
      children: [
        Text(title),
        enabled
            ? Container(
                height: 30,
                width: 70,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: Center(
                  child: DropdownButton<UtmFuso>(
                    value: variable,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (UtmFuso? newValue) {
                      faz(newValue as UtmFuso);
                      setState(() {});
                    },
                    items:
                        options.map<DropdownMenuItem<UtmFuso>>((UtmFuso value) {
                      return DropdownMenuItem<UtmFuso>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox(width: 50, height: 60),
      ],
    );
  }

  Column dropDownZona({
    required String title,
    bool enabled = true,
    required List<UtmZona> options,
    required UtmZona variable,
    required Function(UtmZona) faz,
  }) {
    return Column(
      children: [
        Text(title),
        enabled
            ? Container(
                height: 30,
                width: 70,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: Center(
                  child: DropdownButton<UtmZona>(
                    value: variable,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (UtmZona? newValue) {
                      faz(newValue as UtmZona);
                      setState(() {});
                    },
                    items:
                        options.map<DropdownMenuItem<UtmZona>>((UtmZona value) {
                      return DropdownMenuItem<UtmZona>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox(width: 50, height: 60),
      ],
    );
  }
  // Column dropDown<T>({
  //   required String title,
  //   bool enabled = true,
  //   required List<T> options,
  //   required T variable,
  //   required Function(T) faz,
  // }) {
  //   return Column(
  //     children: [
  //       Text(title),
  //       enabled
  //           ? Container(
  //               height: 30,
  //               width: 170,
  //               padding: const EdgeInsets.symmetric(horizontal: 5.0),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 border: Border.all(style: BorderStyle.solid, width: 0.80),
  //               ),
  //               child: Center(
  //                 child: DropdownButton<T>(
  //                   value: variable,
  //                   icon: const Icon(Icons.arrow_downward),
  //                   underline: Container(
  //                     height: 0,
  //                     color: Colors.deepPurpleAccent,
  //                   ),
  //                   borderRadius: BorderRadius.circular(10),
  //                   onChanged: (T? newValue) {
  //                     faz(newValue as T);
  //                     setState(() {});
  //                   },
  //                   items: options.map<DropdownMenuItem<T>>((T value) {
  //                     return DropdownMenuItem<T>(
  //                       value: value,
  //                       child: Text(value.name),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             )
  //           : const SizedBox(width: 50, height: 60),
  //     ],
  //   );
  // }
}
