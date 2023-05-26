import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:zartek_project/Controllers/login_controller.dart';

// ignore: must_be_immutable
class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  final TextEditingController phoneNumController = TextEditingController();

  OtpFieldController otpController = OtpFieldController();

  LoginController controller = Get.put(LoginController());

  bool isLoading = false;

  bool buttonChange = true;

  int start = 30;

  bool wait = false;

  String buttonName = "send";

  String verificationID = "";

  String smsCode = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Phone Authentication",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.green,
            ),
            body: Form(
              key: formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      _textField(),
                      const SizedBox(
                        height: 70,
                        child: Center(
                          child: Text(
                            "Enter 6 digit OTP",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      _otpField(),
                      const SizedBox(
                        height: 40,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: "Send OTP again in  ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "00:$start",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w400)),
                          const TextSpan(
                              text: "  sec",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold))
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      buttonChange
                          ? GestureDetector(
                              onTap: wait
                                  ? null
                                  : () async {
                                      if (formKey.currentState!.validate()) {
                                        startTime();
                                        setState(() {
                                          start = 30;
                                          wait = true;
                                          buttonName = "Resend";
                                          buttonChange = false;
                                        });
                                        await controller.verificationNumber(
                                            "+91 ${phoneNumController.text}",
                                            context,
                                            setData);
                                      }

                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus &&
                                          currentFocus.focusedChild != null) {
                                        currentFocus.focusedChild!.unfocus();
                                      }
                                    },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xffff9601),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Send OTP",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xfffbe2ae),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.signInCredential(
                                    verificationID, smsCode, context);
                                setState(() {
                                  buttonChange = true;
                                });
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus &&
                                    currentFocus.focusedChild != null) {
                                  currentFocus.focusedChild!.unfocus();
                                }
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xffff9601),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Verify OTP",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xfffbe2ae),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  ///PhoneNumber Field

  Widget _textField() {
    return GetBuilder<LoginController>(
      builder: (phoneCltr) {
        return Container(
          width: MediaQuery.of(context).size.width - 45,
          height: 60,
          decoration: BoxDecoration(
            // color: const Color(0xff1d1d1d),
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 18),
              controller: phoneNumController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              validator: (val) {
                if (phoneNumController.text.length != 10) {
                  return "Phone number invalid";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: "Enter your Phone Number",
                hintStyle: TextStyle(color: Colors.white54, fontSize: 15),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  child: Text(
                    "(+91)",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// OTP Field

  Widget _otpField() {
    return OTPTextField(
      controller: otpController,
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 50,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.green,
        borderColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (pin) {
        print("Changed: " + pin);
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  /// Remaining Time

  void startTime() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void setData(verificationId) {
    setState(() {
      verificationID = verificationId;
    });
    startTime();
  }
}
