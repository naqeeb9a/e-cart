import 'package:ecart_driver/controllers/Withdraw%20amount/withdraw_amount_controller.dart';
import 'package:ecart_driver/controllers/transaction/transaction_controller.dart';
import 'package:ecart_driver/controllers/wallet/wallet_controller.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/widgets/snackbar_widget.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  void initState() {
    WalletController walletController = Get.find();
    walletController.getWallet();
    TransactionController transactionController = Get.find();
    transactionController.getTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF8FAF8),
        title: const Text(
          AppConstants.wallet,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GetBuilder<WalletController>(builder: (walletController) {
              if (walletController.loading) {
                return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
              }
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(
                        "\$ ${walletController.walletModel?.wallet?.balance.toString() ?? ""}",
                        style: const TextStyle(
                            fontSize: 30,
                            fontFamily: FontConstants.bold,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: const Text(
                        AppConstants.remainingAmount,
                        style: TextStyle(
                            fontFamily: FontConstants.medium,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 30)),
                          onPressed: () {
                            _withdrawDialog();
                          },
                          child: Text(
                            AppConstants.withdraw,
                            style: TextStyle(
                                fontFamily: FontConstants.bold,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.primary),
                          )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildContainer(
                          const Color(0xffFF5555),
                          "pending",
                          AppConstants.totalJobs,
                          walletController.walletModel?.completedOrders
                                  .toString() ??
                              ""),
                      const SizedBox(width: 16),
                      _buildContainer(
                          const Color(0xff1B7575),
                          "wallet",
                          AppConstants.withdrawAmount,
                          "\$ ${walletController.walletModel?.wallet?.withdrawAmount.toString() ?? ""}"),
                    ],
                  ),
                ],
              );
            }),
            const SizedBox(height: 16),
            Expanded(child: buildEarningList()),
          ],
        ),
      ),
    );
  }

  TextEditingController priceController = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cvvCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  FocusNode priceNode = FocusNode();
  FocusNode cardNumberNode = FocusNode();
  FocusNode expiryDateNode = FocusNode();
  FocusNode cardHolderNameNode = FocusNode();
  FocusNode cvvCodeNode = FocusNode();
  FocusNode phoneNumberNode = FocusNode();

  _withdrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AppConstants.withdraw,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff1B7575),
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Amount you want to withdraw",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                textField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintText: "Account Number",
                  controller: cardNumber,
                  focusNode: cardNumberNode,
                  isCode: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                textField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  hintText: "Account Holder Name",
                  controller: cardHolderName,
                  focusNode: cardHolderNameNode,
                  isCode: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                textField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  hintText: "Expiry",
                  controller: expiryDate,
                  focusNode: expiryDateNode,
                  isCode: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                textField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintText: "CVV Code",
                  controller: cvvCode,
                  focusNode: cvvCodeNode,
                  isCode: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                textField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintText: "Enter phone number",
                  controller: phoneNumber,
                  focusNode: phoneNumberNode,
                  isCode: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: textField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        hintText: AppConstants.salePriceHint,
                        controller: priceController,
                        focusNode: priceNode,
                        isCode: true,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 65,
                      decoration: const BoxDecoration(
                          color: Color(0xffF1F2ED),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: const Icon(
                        Icons.attach_money,
                        color: Color(0xff1B7575),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.white,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        AppConstants.cancel,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.bold,
                        ),
                      ),
                    )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        if (priceController.text == "") {
                          showMessage("Please specify a price");
                          return;
                        }
                        if (cardNumber.text == "") {
                          showMessage("Please specify a card number");
                          return;
                        }
                        if (cardHolderName.text == "") {
                          showMessage("Please specify a card holder name");
                          return;
                        }
                        if (expiryDate.text == "") {
                          showMessage("Please specify an expiry date");
                          return;
                        }
                        if (cvvCode.text == "") {
                          showMessage("Please specify a Cvv Code");
                          return;
                        }
                        if (phoneNumber.text == "") {
                          showMessage("Please specify a phone number");
                          return;
                        }
                        WalletWithdrawController walletWithdrawController =
                            Get.find();
                        walletWithdrawController.withdrawAmount({
                          "amount": priceController.text,
                          "phone": phoneNumber.text,
                          "cardNumber": cardNumber.text,
                          "cardHolderName": cardHolderName.text,
                          "expMonth": expiryDate.text.split("/").first,
                          "expYear": expiryDate.text.split("/").last,
                          "cvc": cvvCode.text
                        });
                      },
                      child: GetBuilder<WalletWithdrawController>(
                          builder: (walletWithdrawController) {
                        if (walletWithdrawController.loading) {
                          return const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                        }
                        return const Text(
                          AppConstants.withdraw,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontConstants.bold,
                          ),
                        );
                      }),
                    ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildEarningList() =>
      GetBuilder<TransactionController>(builder: (transactionController) {
        if (transactionController.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (transactionController.transactionModel?.transactions?.isEmpty ??
            true) {
          return const Center(
            child: Text("No transactions history available"),
          );
        }
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16),
          itemCount:
              transactionController.transactionModel?.transactions?.length ?? 0,
          itemBuilder: (BuildContext context, int index) =>
              buildEarningItem(index),
        );
      });

  Widget buildEarningItem(index) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xffEAEAEA)),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID # 219387",
                  style: TextStyle(
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "Total: \$ 512",
                  style: TextStyle(
                      fontFamily: FontConstants.medium,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff969696)),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date: 13-07-2021",
                  style: TextStyle(
                      fontFamily: FontConstants.medium,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff969696)),
                ),
                Text(
                  "Earned: \$ 82",
                  style: TextStyle(
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            )
          ],
        ),
      );

  Widget _buildContainer(
          Color color, String icon, String subTitle, String amount) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "images/${icon}_icon.svg",
                // ignore: deprecated_member_use
                color: color,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 30),
              Text(
                amount,
                style: TextStyle(
                    fontFamily: FontConstants.bold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                    fontFamily: FontConstants.medium,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
        ),
      );
}
