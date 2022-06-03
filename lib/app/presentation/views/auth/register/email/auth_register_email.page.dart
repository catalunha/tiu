import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/auth/email/auth_register_email_controller.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/presentation/views/utils/app_button.dart';
import 'package:tiu/app/presentation/views/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class AuthRegisterEmailPage extends StatefulWidget {
  final AuthRegisterEmailController _authRegisterEmailController = Get.find();

  AuthRegisterEmailPage({Key? key}) : super(key: key);

  @override
  State<AuthRegisterEmailPage> createState() => _AuthRegisterEmailPageState();
}

class _AuthRegisterEmailPageState extends State<AuthRegisterEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _phoneEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.primaryColorDark,
                    ),
                  ),
                  const Text(
                      'Preencha os campos abaixo para criar o seu cadastro.'),
                  const SizedBox(height: 20),
                  AppTextFormField(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('email obrigatório.'),
                      Validatorless.email('Email inválido.'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  AppTextFormField(
                    label: 'Senha',
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória.'),
                      Validatorless.min(6, 'Minimo de 6 caracteres.'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextFormField(
                    label: 'Confirme senha',
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required(
                            'confirmação de senha obrigatória.'),
                        Validatorless.min(6, 'Minimo de 6 caracteres.'),
                        Validatorless.compare(_passwordEC,
                            'Senha diferente do informado anteriormente.')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      'Após clicar em CADASTRAR você receberá um email para validação deste cadastro. É necessário ir na caixa de entrada do email informado aqui e validar seu cadastro antes de tentar login.'),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                    label: 'Cadastrar',
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        log('formValid');
                        widget._authRegisterEmailController.registerEmail(
                          email: _emailEC.text.trim(),
                          password: _passwordEC.text.trim(),
                        );
                      } else {
                        log('formNotValid');
                      }
                    },
                    width: context.width,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
