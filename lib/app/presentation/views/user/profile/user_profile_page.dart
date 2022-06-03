import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/user/profile/user_profile_controller.dart';
import 'package:tiu/app/presentation/views/user/profile/part/user_profile_photo.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/presentation/views/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final UserProfileController _userProfileController = Get.find();

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameTec = TextEditingController();
  final _nicknameTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  final _phoneTec = TextEditingController();
  final _sectorTec = TextEditingController();
  final _positionTec = TextEditingController();
  final _activityTec = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameTec.text =
        widget._userProfileController.userProfile?.fullName ?? "";
    _nicknameTec.text =
        widget._userProfileController.userProfile?.nickname ?? "";
    _descriptionTec.text =
        widget._userProfileController.userProfile?.description ?? "";
    _phoneTec.text = widget._userProfileController.userProfile?.phone ?? "";
    _sectorTec.text = widget._userProfileController.userProfile?.sector ?? "";
    _positionTec.text =
        widget._userProfileController.userProfile?.position ?? "";
    _activityTec.text =
        widget._userProfileController.userProfile?.activity ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: const Text('Editar seu perfil'),
      ),
      body: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextFormField(
                  label: 'Nome completo para documentos.',
                  controller: _fullNameTec,
                  validator:
                      Validatorless.required('Nome completo é obrigatório'),
                ),
                AppTextFormField(
                  label: 'Nome curto mais conhecido para crachá.',
                  controller: _nicknameTec,
                  validator: Validatorless.required('Nome curto é obrigatório'),
                ),
                AppTextFormField(
                  label: 'Breve descrição sobre você.',
                  controller: _descriptionTec,
                ),
                AppTextFormField(
                  label: 'Seu telefone com DDD. Apenas numeros',
                  controller: _phoneTec,
                ),
                AppTextFormField(
                  label: 'Seu setor na empresa.',
                  controller: _sectorTec,
                ),
                AppTextFormField(
                  label: 'Seu cargo/função/posição na empresa.',
                  controller: _positionTec,
                ),
                AppTextFormField(
                  label: 'Sua atividade no projeto.',
                  controller: _activityTec,
                ),
                UserProfilePhoto(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      await widget._userProfileController.append(
                        fullName: _fullNameTec.text,
                        nickname: _nicknameTec.text,
                        description: _descriptionTec.text,
                        sector: _sectorTec.text,
                        position: _positionTec.text,
                        activity: _activityTec.text,
                      );
                      Get.back();
                    }
                  },
                  child: const Text('Salvar atualização.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
