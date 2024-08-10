import 'package:flutter/material.dart';
import 'package:initial/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:initial/presentation/login/login_viewmodel.dart';
import 'package:initial/presentation/resources/assets_manager.dart';
import 'package:initial/presentation/resources/color_manager.dart';
import 'package:initial/presentation/resources/strings_manager.dart';
import 'package:initial/presentation/resources/values_manager.dart';

import '../../app/di.dart';
import '../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {




  
  LoginViewModel _viewModel = instance<LoginViewModel>();


  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(
      () => _viewModel.setUserName(_usernameController.text),
    );
    _passwordController.addListener(
      () => _viewModel.setPassword(_passwordController.text),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: ColorManager.white,
      
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context,snapshot){
        return   snapshot.data?.getScreenWidget(
            context, 
            _getContentwidget(), 
            (){
              _viewModel.login();
            },
          ) ?? _getContentwidget() ;
        },
      ),
    );
  }

  Widget _getContentwidget() {
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (content, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: AppStrings.Username,
                          labelText: AppStrings.Username,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.UsernameError,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (content, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppStrings.Password,
                          labelText: AppStrings.Password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.PasswordError,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: Text(
                            AppStrings.login,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.forgotPasswordRoute);
                    },
                    child: Text(
                      AppStrings.ForgetPassword,
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                   TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.registerRoute);
                    },
                    child: Text(
                      AppStrings.registerText,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
