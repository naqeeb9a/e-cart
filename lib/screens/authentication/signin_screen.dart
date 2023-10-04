import 'package:ecart_driver/controllers/authentication/login_controller.dart';
import 'package:ecart_driver/screens/authentication/signup_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:ecart_driver/widgets/text_field_label.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController =
      TextEditingController(text: "driver3@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "Password@123");
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool obsure = true;
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  bool rememberMe = false;

  var helpingMethod = HelpingMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _key,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          const Center(
            child: Text(
              AppConstants.logInTextTitle,
              style: TextStyle(
                fontSize: 30,
                fontFamily: FontConstants.bold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            AppConstants.logInTextDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: FontConstants.regular,
            ),
          ),
          const SizedBox(height: 30),
          textFieldLabel(label: AppConstants.emailTextLabel, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            hintText: AppConstants.emailTextHint,
            controller: emailController,
            focusNode: emailNode,
            validator: (value) {
              if (value == null ||
                  value == "" ||
                  !value.contains("@") ||
                  !value.contains(".")) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          textFieldLabel(
              label: AppConstants.passwordTextLabel, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.done,
            hintText: AppConstants.passwordTextHint,
            controller: passwordController,
            focusNode: passwordNode,
            isEye: true,
            onPressed: () {
              setState(() {
                obsure = !obsure;
              });
            },
            isPassword: obsure,
            validator: (value) {
              if (value == null || value == "") {
                return "value cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          GetBuilder<LoginController>(builder: (loginController) {
            if (loginController.loading) {
              return const SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()));
            }
            return ElevatedButton(
              onPressed: () {
                if (_key.currentState?.validate() == true) {
                  loginController.loginUser(
                      context, emailController.text, passwordController.text);
                }
              },
              child: const Text(
                AppConstants.signInText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium,
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: rememberMe,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                  title: const Text(
                    AppConstants.rememberMeText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontConstants.regular,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  AppConstants.forgotPasswordText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff0B59ED),
                    fontWeight: FontWeight.w500,
                    fontFamily: FontConstants.medium,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              helpingMethod.openScreen(
                  context: context, screen: SignUpScreen());
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: AppConstants.notAccountText,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontConstants.regular,
                    ),
                  ),
                  TextSpan(
                    text: AppConstants.signUpTextTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
