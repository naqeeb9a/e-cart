import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecart_driver/screens/splash_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/global.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/driver_document.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:ecart_driver/widgets/text_field_label.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isProfile = true;
  int selectedTab = 0;
  PageController? controller;
  TextEditingController nameController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController swiftController = TextEditingController();
  List<String> _tabs = [];

  FocusNode nameNode = FocusNode();
  FocusNode vinNode = FocusNode();
  FocusNode licenseNode = FocusNode();
  FocusNode bankNameNode = FocusNode();
  FocusNode accountNumberNode = FocusNode();
  FocusNode ibanNode = FocusNode();
  FocusNode swiftNode = FocusNode();
  List _documents = [];
  String? selectedAccountType;
  List<String> _accountTypes = [];
  List<String> vehiclesType = [];
  String? selectedVehicle;
  final HelpingMethods helpingMethods = HelpingMethods();

  @override
  void initState() {
    controller = PageController(initialPage: selectedTab);
    _documents = [
      {
        "title": AppConstants.driverPermit,
        "file": File(""),
      },
      {
        "title": AppConstants.certifiedCopy,
        "file": File(""),
      },
      {
        "title": AppConstants.certificateOfCharacter,
        "file": File(""),
      },
      {
        "title": AppConstants.insurance,
        "file": File(""),
      },
      {
        "title": AppConstants.vehicleImage,
        "file": File(""),
      },
      {
        "title": AppConstants.proofOfAddress,
        "file": File(""),
      },
    ];
    _tabs = [
      AppConstants.profile,
      AppConstants.bankDetail,
    ];
    _accountTypes = [
      AppConstants.savingAccount,
      AppConstants.currentAccount,
    ];

    vehiclesType = [
      AppConstants.bike,
      AppConstants.car,
      AppConstants.truck,
    ];
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          AppConstants.settings,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Global.storageService.removeUser().then((value) =>
                  helpingMethods.openAndCloseAllScreen(
                      context: context, screen: SplashScreen()));
            },
            child: Chip(
                backgroundColor: const Color(0xffFFEAEA),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                label: const Text(AppConstants.logout),
                labelStyle: const TextStyle(
                    color: Color(0xffFF5555),
                    fontWeight: FontWeight.w600,
                    fontFamily: FontConstants.bold)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabs(),
          _buildPages(),
        ],
      ),
    );
  }

  Widget _buildPages() => Expanded(
          child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildProfile(),
          _buildBankDetail(),
        ],
      ));

  Widget _buildBankDetail() => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          textFieldLabel(label: AppConstants.bankName, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            hintText: AppConstants.bankNameHint,
            controller: bankNameController,
            focusNode: bankNameNode,
          ),
          const SizedBox(height: 16),
          textFieldLabel(
              label: AppConstants.bankAccountNumber, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            hintText: AppConstants.bankAccountNumberHint,
            controller: accountNumberController,
            focusNode: accountNumberNode,
          ),
          const SizedBox(height: 16),
          textFieldLabel(label: AppConstants.accountType, isRequired: true),
          const SizedBox(height: 16),
          DropdownButton2(
            isExpanded: true,
            underline: const Text(""),
            hint: const Text(
              AppConstants.accountTypeHint,
              style: TextStyle(
                  color: Color(0xffBCBCBC),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium),
              overflow: TextOverflow.ellipsis,
            ),
            items: _accountTypes
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: FontConstants.medium,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedAccountType,
            onChanged: (value) {
              setState(() {
                selectedAccountType = value as String;
              });
            },
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),
            buttonHeight: 58,
            buttonPadding: const EdgeInsets.only(left: 16, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffEAEAEA)),
              color: Colors.white,
            ),
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            dropdownElevation: 3,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
          const SizedBox(height: 16),
          textFieldLabel(label: AppConstants.iBan),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            hintText: AppConstants.iBanHint,
            controller: ibanController,
            focusNode: ibanNode,
          ),
          const SizedBox(height: 16),
          textFieldLabel(label: AppConstants.swiftCode),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            hintText: AppConstants.swiftCodeHint,
            controller: swiftController,
            focusNode: swiftNode,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                AppConstants.saveAccount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium,
                ),
              )),
        ],
      );

  Widget _buildProfile() => ListView(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffEAEAEA),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const FadeInImage(
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: AssetImage("AppConstants.placeholder"),
                    image: NetworkImage(AppConstants.userImage),
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
                            fontFamily: FontConstants.bold,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: 4),
                      const Text(AppConstants.uploadPicHint,
                          style: TextStyle(
                            color: Color(0xff969696),
                            fontFamily: FontConstants.medium,
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
                              color: Theme.of(context).colorScheme.primary,
                              width: 1),
                        ),
                        onPressed: () {},
                        child: Text(
                          AppConstants.browse,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontConstants.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          textFieldLabel(label: AppConstants.displayName, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: AppConstants.displayNameHint,
            controller: nameController,
            focusNode: nameNode,
          ),
          const SizedBox(height: 16),
          textFieldLabel(label: AppConstants.vin, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            hintText: AppConstants.vinHint,
            controller: vinController,
            focusNode: vinNode,
          ),
          const SizedBox(height: 16),
          textFieldLabel(label: AppConstants.licenseNumber, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            hintText: AppConstants.vinHint,
            controller: licenseController,
            focusNode: licenseNode,
          ),
          const SizedBox(height: 16),
          textFieldLabel(label: AppConstants.selectVehicle, isRequired: true),
          const SizedBox(height: 16),
          DropdownButton2(
            isExpanded: true,
            underline: const Text(""),
            hint: const Text(
              'Select your vehicle',
              style: TextStyle(
                  color: Color(0xffBCBCBC),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium),
              overflow: TextOverflow.ellipsis,
            ),
            items: vehiclesType
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: FontConstants.medium,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedVehicle,
            onChanged: (value) {
              setState(() {
                selectedVehicle = value as String;
              });
            },
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),
            buttonHeight: 58,
            buttonPadding: const EdgeInsets.only(left: 16, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffEAEAEA)),
              color: Colors.white,
            ),
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            dropdownElevation: 3,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
          const SizedBox(height: 16),
          textFieldLabel(label: AppConstants.licenseExpiry, isRequired: true),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: textField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintText: AppConstants.carInsuranceExpiryHint,
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                  isCode: true,
                  readOnly: true,
                ),
              ),
              Container(
                height: 58,
                width: 65,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              )
            ],
          ),
          const SizedBox(height: 16),
          textFieldLabel(
              label: AppConstants.carInsuranceExpiry, isRequired: true),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: textField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintText: AppConstants.carInsuranceExpiryHint,
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                  isCode: true,
                  readOnly: true,
                ),
              ),
              Container(
                height: 58,
                width: 65,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              )
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            itemCount: _documents.length,
            shrinkWrap: true,
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              return buildAddImage(_documents[index], () {}, () {});
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                AppConstants.update,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium,
                ),
              )),
          const SizedBox(height: 16),
        ],
      );

  Widget _buildTabs() => SizedBox(
        height: 75,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 16),
          itemCount: _tabs.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              selectedTab = index;
              setState(() {});
              controller!.animateToPage(selectedTab,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            child: Chip(
                label: Text(_tabs[index]),
                backgroundColor: selectedTab == index
                    ? const Color(0xffE1F5E9)
                    : const Color(0xffF3F2F4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 13),
                labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                labelStyle: TextStyle(
                    color: selectedTab == index
                        ? const Color(0xff1B7575)
                        : const Color(0xff969696),
                    fontFamily: FontConstants.medium,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );
}
