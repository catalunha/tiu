import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/auth/login/login_controller.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/presentation/views/utils/app_button.dart';
import 'package:tiu/app/presentation/views/utils/app_textformfield.dart';
import 'package:tiu/app/presentation/views/utils/app_theme.dart';
import 'package:tiu/app/routes.dart';
import 'package:validatorless/validatorless.dart';

class AuthLoginPage extends StatefulWidget {
  final LoginController _loginController = Get.find();

  AuthLoginPage({Key? key}) : super(key: key);

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTec = TextEditingController();
  final _passwordTec = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constrainsts) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constrainsts.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: context.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AppTextFormField(
                          label: 'E-Mail',
                          controller: _emailTec,
                          validator: Validatorless.multiple([
                            Validatorless.required('email obrigatório.'),
                            Validatorless.email('Email inválido.'),
                          ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppTextFormField(
                          label: 'Senha',
                          controller: _passwordTec,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha obrigatória.'),
                            Validatorless.min(6, 'Minimo de 6 caracteres.'),
                          ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppButton(
                          label: 'Acessar',
                          onPressed: () {
                            final formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              log('formValid');
                              widget._loginController.loginEmail(
                                  _emailTec.text.trim(),
                                  _passwordTec.text.trim());
                            } else {
                              log('formNotValid');
                            }
                          },
                          width: context.width,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Esqueceu sua senha ?'),
                            TextButton(
                              onPressed: () {
                                if (_emailTec.text.isNotEmpty) {
                                  widget._loginController
                                      .forgotPassword(_emailTec.text.trim());
                                } else {
                                  Get.snackbar(
                                    'Oops',
                                    'Digite email para prosseguir',
                                    backgroundColor: Colors.red,
                                    margin: const EdgeInsets.all(10),
                                  );
                                }
                              },
                              child: const Text(
                                'Crie uma nova.',
                                style: AppTheme.textBold,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Não possui uma conta ?'),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.authRegisterEmail);
                              },
                              child: const Text(
                                'CADASTRE-SE.',
                                style: AppTheme.textBold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
