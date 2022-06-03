import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar_title.dart';
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

  @override
  void initState() {
    super.initState();
    _nameTEC.text = widget._milestoneController.milestone?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBarTitle(
        title:
            '${widget._milestoneController.milestone == null ? "Criar" : "Editar"} marco',
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
