import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/presentation/views/utils/app_number_formfield.dart';
import 'package:tiu/app/presentation/views/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class MilestoneAppendPage extends StatefulWidget {
  final MilestoneController _milestoneController = Get.find();

  MilestoneAppendPage({Key? key}) : super(key: key);

  @override
  State<MilestoneAppendPage> createState() => _ProductAppendPageState();
}

class _ProductAppendPageState extends State<MilestoneAppendPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  final _utmxTEC = TextEditingController();
  final _utmyTEC = TextEditingController();
  final _utmzTEC = TextEditingController();
  final _utmfusoTEC = TextEditingController();
  final _utmzoneTEC = TextEditingController();
  final _utmpoleTEC = TextEditingController();
  final _latTEC = TextEditingController();
  final _longTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameTEC.text = widget._milestoneController.milestone?.name ?? '';
    _utmxTEC.text =
        widget._milestoneController.milestone?.utmx?.toString() ?? '';
    _utmyTEC.text =
        widget._milestoneController.milestone?.utmy?.toString() ?? '';
    _utmzTEC.text =
        widget._milestoneController.milestone?.utmz?.toString() ?? '';
    _utmfusoTEC.text =
        widget._milestoneController.milestone?.utmfuso?.toString() ?? '';
    _utmzoneTEC.text =
        widget._milestoneController.milestone?.utmzone?.toString() ?? '';
    _utmpoleTEC.text =
        widget._milestoneController.milestone?.utmpole?.toString() ?? '';
    _latTEC.text = widget._milestoneController.milestone?.lat?.toString() ?? '';
    _longTEC.text =
        widget._milestoneController.milestone?.long?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: Text(
            '${widget._milestoneController.milestone == null ? "Criar" : "Editar"} marco'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'Nome do marco',
                  controller: _nameTEC,
                  validator: Validatorless.required('Nome é obrigatório'),
                ),
                AppNumberFormField(
                  label: 'UTM X (Leste<->oeste em m)',
                  controller: _utmxTEC,
                  validator: Validatorless.multiple([
                    Validatorless.number('Informe um número válido'),
                    // Validatorless.min(100, 'Maior que 100,000.'),
                    // Validatorless.max(80, 'Menor que 800000')
                  ]),
                ),
                AppNumberFormField(
                  label: 'UTM Y (Norte<->sul em m)',
                  controller: _utmyTEC,
                  validator: Validatorless.multiple([
                    Validatorless.number('Informe um número válido'),
                    // Validatorless.min(0, 'Maior que 0'),
                    // Validatorless.max(10000000, 'Menor que 10000000'),
                  ]),
                ),
                AppNumberFormField(
                  label: 'UTM Z (Elevação em )',
                  controller: _utmzTEC,
                  validator: Validatorless.number('Informe um número válido'),
                ),
                AppNumberFormField(
                  label: 'UTM Fuso (18 a 25)',
                  controller: _utmfusoTEC,
                  validator: Validatorless.multiple([
                    Validatorless.number('Informe um número válido'),
                    // Validatorless.min(18, 'Maior que 18'),
                    // Validatorless.max(25, 'Menor que 25'),
                  ]),
                ),
                AppTextFormField(
                  label: 'UTM Zone (H,J,K,L,M,N)',
                  controller: _utmzoneTEC,
                ),
                AppTextFormField(
                  label: 'UTM Polo (N,S)',
                  controller: _utmpoleTEC,
                ),
                AppNumberFormField(
                  label: 'Latitude (decimais)',
                  controller: _latTEC,
                  validator: Validatorless.multiple([
                    Validatorless.number('Informe um número válido'),
                    // Validatorless.min(-90, 'Maior que -90'),
                    // Validatorless.max(90, 'Menor que 90'),
                  ]),
                ),
                AppNumberFormField(
                  label: 'Longitude (decimais)',
                  controller: _longTEC,
                  validator: Validatorless.multiple([
                    Validatorless.number('Informe um número válido'),
                    // Validatorless.min(-180, 'Maior que -180'),
                    // Validatorless.max(180, 'Menor que 180'),
                  ]),
                ),
                const SizedBox(height: 16),
                delete(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: context.primaryColor,
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._milestoneController.append(
              name: _nameTEC.text,
              utmx: double.tryParse(_utmxTEC.text),
              utmy: double.tryParse(_utmyTEC.text),
              utmz: double.tryParse(_utmzTEC.text),
              utmfuso: _utmfusoTEC.text,
              utmzone: _utmzoneTEC.text,
              utmpole: _utmpoleTEC.text,
              lat: double.tryParse(_latTEC.text),
              long: double.tryParse(_longTEC.text),
            );
            Get.back();
          }
        },
        label: const Text(
          'Salvar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Visibility delete() {
    return Visibility(
      visible: widget._milestoneController.milestone != null,
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: const Icon(
            Icons.delete_forever,
          ),
          onPressed: () {
            widget._milestoneController
                .delete(widget._milestoneController.milestone!.id!);
          },
          tooltip: 'Apagar este marco',
        ),
      ),
    );
  }
}
