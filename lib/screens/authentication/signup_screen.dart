import 'dart:io';

import 'package:ecart_driver/data/remote/network/response/app_state.dart';
import 'package:ecart_driver/data/remote/network/response/network_response.dart';
import 'package:ecart_driver/model/request_body.dart';
import 'package:ecart_driver/screens/success_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/utils/image_helper.dart';
import 'package:ecart_driver/utils/textfield_validator.dart';
import 'package:ecart_driver/view_model/auth_view_model.dart';
import 'package:ecart_driver/widgets/driver_document.dart';
import 'package:ecart_driver/widgets/snackbar_widget.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:ecart_driver/widgets/text_field_label.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../widgets/loading_dialog.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final PhoneNumber phone =
      PhoneNumber(countryISOCode: "", countryCode: "", number: "");
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPasswordController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nationalController = TextEditingController();
  final TextEditingController passportController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();

  final FocusNode firstNameNode = FocusNode();
  final FocusNode registrationNode = FocusNode();
  final FocusNode licenseNode = FocusNode();
  final FocusNode nationalNode = FocusNode();
  final FocusNode passportNode = FocusNode();
  final FocusNode addressNode = FocusNode();
  final FocusNode lastNameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode sPhoneNode = FocusNode();
  final FocusNode conformPasswordNode = FocusNode();

  final bool rememberMe = false;
  final imageHelper = ImageHelper();
  final picker = ImagePicker();
  final AuthViewModel viewModel = Get.find();
  final helpingMethod = HelpingMethods();
  final textFieldValidator = TextFieldValidator();
  final formKey = GlobalKey<FormState>();

  signUp(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (viewModel.documents[0]["file"].path == "") {
      showMessage("Please select driver permit");
      return;
    }
    if (viewModel.documents[1]["file"].path == "") {
      showMessage("Please select certificate copy");
      return;
    }
    if (viewModel.documents[2]["file"].path == "") {
      showMessage("Please select character certificate");
      return;
    }
    if (viewModel.documents[4]["file"].path == "") {
      showMessage("Please select vehicle image");
      return;
    }
    if (viewModel.documents[5]["file"].path == "") {
      showMessage("Please select proof of address");
      return;
    }
    showLoadingDialog(context: context);
    late ApiResponse userImageResponse;
    if (viewModel.userImage!.value.path != "") {
      userImageResponse = await viewModel.uploadImage(
          request: RequestBody(files: [
        {"key": "images", "filePath": viewModel.userImage!.value.path}
      ]));
    }

    ApiResponse rootPermit = await viewModel.uploadDocument(
        request: RequestBody(files: [
      {"key": "documents", "filePath": viewModel.documents[0]["file"].path}
    ], directory: "rootPermit"));
    ApiResponse certifiedCopy = await viewModel.uploadDocument(
        request: RequestBody(files: [
      {"key": "documents", "filePath": viewModel.documents[1]["file"].path}
    ], directory: "certifiedCopy"));
    ApiResponse characrCertifiate = await viewModel.uploadDocument(
        request: RequestBody(files: [
      {"key": "documents", "filePath": viewModel.documents[2]["file"].path}
    ], directory: "characrCertifiate"));
    late ApiResponse insuranceDocument;
    if (viewModel.documents[3]["file"].path != "") {
      insuranceDocument = await viewModel.uploadDocument(
          request: RequestBody(files: [
        {"key": "documents", "filePath": viewModel.documents[3]["file"].path}
      ], directory: "insuranceDocument"));
    }
    ApiResponse veichleImage = await viewModel.uploadDocument(
        request: RequestBody(files: [
      {"key": "documents", "filePath": viewModel.documents[4]["file"].path}
    ], directory: "veichleImage"));
    ApiResponse addressProof = await viewModel.uploadDocument(
        request: RequestBody(files: [
      {"key": "documents", "filePath": viewModel.documents[5]["file"].path}
    ], directory: "addressProof"));

    var body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "address": addressController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": "driver",
      "phone": {"code": phone.countryCode, "number": phone.number},
      if (viewModel.userImage!.value.path != "")
        "profileImage": userImageResponse.data,
      "driverAttributes": {
        "nationalIdentityNumber": nationalController.text,
        "passportNumber": passportController.text,
        "drivingLicenseNumber": licenseController.text,
        "vehicleRegistrationNumber": registrationController.text,
        "rootPermit": rootPermit.data,
        "characrCertifiate": characrCertifiate.data,
        if (viewModel.documents[3]["file"].path != "")
          "insuranceDocument": insuranceDocument.data,
        "certifiedCopy": certifiedCopy.data,
        "veichleImage": veichleImage.data,
        "addressProof": addressProof.data
      }
    };
    ApiResponse apiResponse =
        await viewModel.signUpAccount(request: RequestBody(body: body));
    Get.back();
    if (apiResponse.appState == AppState.onSuccess) {
      viewModel.resetSignUp();
      Get.off(() => const SuccessScreen());
      showMessage(apiResponse.data);
    } else {
      showMessage(apiResponse.message!);
    }
  }

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
      body: WillPopScope(
        onWillPop: () async {
          viewModel.resetSignUp();
          return true;
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                AppConstants.signUpTextTitle,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: FontConstants.bold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              AppConstants.signUpTextDesc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: FontConstants.regular,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xffEAEAEA))),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xffE1F5E9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xffEAEAEA)),
                    ),
                    child: Obx(
                      () => viewModel.userImage!.value.path == ""
                          ? Padding(
                              padding: const EdgeInsets.all(25),
                              child: SvgPicture.asset(
                                "images/avatar_icon.svg",
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                viewModel.userImage!.value,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppConstants.uploadPic,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Inter-SemiBold",
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 4),
                        const Text(AppConstants.uploadPicHint,
                            style: TextStyle(
                              color: Color(0xff969696),
                              fontFamily: "Inter-Medium",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            backgroundColor: Colors.white,
                            side: BorderSide(
                                color: Get.theme.colorScheme.primary, width: 1),
                          ),
                          onPressed: () {
                            imageHelper
                                .getImage(picker, ImageSource.gallery)
                                .then((value) {
                              if (value != null) {
                                viewModel.userImage!.value = File(value.path);
                              }
                            });
                          },
                          child: Text(
                            AppConstants.browse,
                            style: TextStyle(
                              color: Get.theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter-Bold",
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            textFieldLabel(label: AppConstants.firstName, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
              ],
              validator: (value) {
                return textFieldValidator.validateEmpty(value, "first name");
              },
              hintText: AppConstants.firstNameHint,
              controller: firstNameController,
              focusNode: firstNameNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(label: AppConstants.lastName, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              hintText: AppConstants.lastNameHint,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
              ],
              validator: (value) {
                return textFieldValidator.validateEmpty(value, "first name");
              },
              controller: lastNameController,
              focusNode: lastNameNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(
                label: AppConstants.emailTextLabel, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              hintText: AppConstants.emailTextHint,
              controller: emailController,
              validator: (value) {
                return textFieldValidator.validateEmail(value ?? "");
              },
              focusNode: emailNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(
                label: AppConstants.phoneTextLabel, isRequired: true),
            const SizedBox(height: 16),
            IntlPhoneField(
              focusNode: sPhoneNode,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xff76B139),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffEAEAEA),
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Phone Number",
                  hintStyle: const TextStyle(
                      color: Color(0xffBCBCBC),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstants.medium)),
              onChanged: (phoneNumber) {
                phone.countryCode = phoneNumber.countryCode;
                phone.number = phoneNumber.number;
              },
              onCountryChanged: (country) {},
            ),
            const SizedBox(height: 16),
            textFieldLabel(label: "National ID #", isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              hintText: AppConstants.addNumberHere,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              validator: (value) {
                return textFieldValidator.validateEmpty(value, "national id");
              },
              controller: nationalController,
              focusNode: nationalNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(label: "Passport ID #"),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
              ],
              hintText: AppConstants.addNumberHere,
              controller: passportController,
              focusNode: passportNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(
                label: AppConstants.vehicleRegistration, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Z-0-9]')),
              ],
              validator: (value) {
                return textFieldValidator.validateEmpty(
                    value, "vehicle registration");
              },
              keyboardType: TextInputType.text,
              hintText: AppConstants.vehicleRegistrationHint,
              controller: registrationController,
              focusNode: registrationNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(label: AppConstants.driverLicense, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              validator: (value) {
                return textFieldValidator.validateEmpty(
                    value, "driving license");
              },
              hintText: AppConstants.addNumberHere,
              controller: licenseController,
              focusNode: licenseNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(label: AppConstants.address, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              hintText: AppConstants.yourAddress,
              validator: (value) {
                return textFieldValidator.validateEmpty(value, "address");
              },
              controller: addressController,
              focusNode: addressNode,
            ),
            const SizedBox(height: 16),
            textFieldLabel(
                label: AppConstants.passwordTextLabel, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.next,
              hintText: AppConstants.passwordTextHint,
              controller: passwordController,
              focusNode: passwordNode,
              isEye: true,
              onPressed: () {
                viewModel.showPassword.value = !viewModel.showPassword.value;
              },
              validator: (value) {
                return textFieldValidator.validatePassword(value ?? "");
              },
              isPassword: viewModel.showPassword.value,
            ),
            const SizedBox(height: 16),
            textFieldLabel(
                label: AppConstants.confirmPassword, isRequired: true),
            const SizedBox(height: 16),
            textField(
              textInputAction: TextInputAction.done,
              hintText: AppConstants.passwordTextHint,
              controller: conformPasswordController,
              isEye: true,
              onPressed: () {
                viewModel.showConfirmPassword.value =
                    !viewModel.showConfirmPassword.value;
              },
              validator: (value) {
                return textFieldValidator.validateConfirmPassword(
                    passwordController.text, value ?? "");
              },
              focusNode: conformPasswordNode,
              isPassword: viewModel.showConfirmPassword.value,
            ),
            const SizedBox(height: 20),
            Obx(
              () => GridView.builder(
                itemCount: viewModel.documents.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return buildAddImage(viewModel.documents[index], () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowedExtensions: [
                        "pdf",
                        "docx",
                        "doc",
                      ],
                      type: FileType.custom,
                    );
                    if (result != null) {
                      PlatformFile file = result.files.first;
                      File imageFile = File(file.path!);
                      if (Platform.isIOS) {
                        final documentPath =
                            (await getApplicationDocumentsDirectory()).path;
                        imageFile = await imageFile.copy(
                            '$documentPath/${path.basename(imageFile.path)}');
                      }
                      viewModel.documents[index]["file"] = imageFile;
                      viewModel.documents.refresh();
                    }
                  }, () {
                    viewModel.documents[index]["file"] = File("");
                    viewModel.documents.refresh();
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                signUp(context);
              },
              child: const Text(
                AppConstants.signUpTextTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
