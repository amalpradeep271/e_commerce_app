import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/data/agreements/model/terms_and_condition_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Terms And Conditions',
      ),
      body: termsAndConditionBody(context),
    );
  }

  termsAndConditionBody(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 30.h,
          ),
          child: Column(
            children: [
              for (TermsAndConditionModel termsandcondition in arrayOfContents)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 8.h,
                    left: 8.w,
                    right: 8.w,
                  ),
                  child: termsandconditioncontent(
                    content: termsandcondition.content,
                    title: termsandcondition.title,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget termsandconditioncontent({
    required String title,
    required String content,
  }) {
    return Text.rich(
        textAlign: TextAlign.justify,
        TextSpan(children: [
          TextSpan(
            text: title,
            style: AppTextStyles.base.kPrimaryColor.s14,
          ),
          TextSpan(
            text: content,
            style: AppTextStyles.base.blackColor.s14,
          ),
        ]));
  }
}

var arrayOfContents = [
  TermsAndConditionModel("Eligibility:",
      "Users must be at least 18 years old and legal residents of the country in which the app is available. They must also have a valid email address, mobile phone number, and a verified payment method."),
  TermsAndConditionModel("User Account:",
      "Users must create a user account to use the app. They must provide accurate and complete information during the registration process, and they are responsible for maintaining the confidentiality of their login credentials."),
  TermsAndConditionModel("Prohibited Uses:",
      "Users must not use the app for any illegal or fraudulent purposes, or to send spam or unsolicited messages. Users must also not use the app to promote hate, violence, or discrimination."),
  TermsAndConditionModel("Liability:",
      "The app is not responsible for any damages or losses resulting from the use of the app or any errors or interruptions in its services."),
  TermsAndConditionModel("Termination:",
      "The app may terminate a user's account or access to the app at any time, for any reason."),
  TermsAndConditionModel("Changes to Terms:",
      "The app may update or change these terms and conditions at any time. Users will be notified of any changes and must accept the new terms to continue using the app."),
];
