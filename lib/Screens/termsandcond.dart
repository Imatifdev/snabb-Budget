import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final List<TermsSection> termsSections = [
    TermsSection(
      heading: 'Termsfeed',
      content: '''
Firstly you must read and understand Termsfeed before using the budget manager app. You feel free to recognize terms and conditions and privacy policy for this application. If you are not comfortable agreeing to any of these terms, kindly do not use this app.
''',
    ),
    TermsSection(
      heading: 'Registration and Use',
      content: '''
The Application is intended for personal use only. Users must provide accurate and complete information during the registration process.
''',
    ),
    TermsSection(
      heading: 'Subscription and Refunds',
      content: '''
The Application may offer various subscription plans. All payments are non-refundable except as provided in our Refund Policy described below. We may change the price for the subscriptions from time to time, and will communicate any price changes to you.
''',
    ),
    TermsSection(
      heading: 'Refund Policy',
      content: '''
If you are not satisfied with your purchase, we offer a 14-days money-back guarantee from the date of purchase. To request a refund, you must contact us within the 14 days. No refunds will be granted after the 14 days.
''',
    ),
    TermsSection(
      heading: 'Modification',
      content: '''
We reserve the right, at our discretion and sole expense, to modify these Terms at any time. Please go through these Terms and Conditions regularly for updates.
''',
    ),
    TermsSection(
      heading: 'Intellectual Property',
      content: '''
We and our sources own the content, design, graphics, compilation, and other intellectual property rights in the Application.
''',
    ),
    TermsSection(
      heading: 'Privacy Policy',
      content: '''
The Application collects, stores, preserves, and shares information about you following its Privacy Policy.
''',
    ),
    TermsSection(
      heading: 'Disclaimers',
      content: '''
You understand and agree that the SNABB BUDGET Application is not responsible for the content, accuracy, or reliability of third-party websites or resources. It is a useful tool for managing finances but should not be relied upon as a substitute for professional financial advice.
''',
    ),
    TermsSection(
      heading: 'Limitation of Liability',
      content: '''
Before using a SNABB BUDGET tool, users must carefully review and understand the limitation on liability agreement. Users should also think about whether they require additional insurance protection to guard against possible losses or damages that might not be covered by the liability restrictions of the application provider.
''',
    ),
    TermsSection(
      heading: 'Indemnification',
      content: '''
You undertake to reimburse and hold us, our subsidiaries, officers, directors, staff members, specialists, licensors, employees, and distributors harmless from any third-party claims, losses, accountability, damages, expenses.
''',
    ),
    TermsSection(
      heading: 'Governing Law',
      content: '''
To maintain consumer rights and ensure the security of their personal data, it is crucial and governed by creators of budget management applications to comprehend and follow all applicable laws and regulations.
''',
    ),
    TermsSection(
      heading: 'Termination',
      content: '''
We reserve the authority to terminate your usage of the Application at any stage for any reason.
''',
    ),
    TermsSection(
      heading: 'Entire Agreement',
      content: '''
These Terms, along with the Privacy Policy and any changes or other agreements you can enter into with us in connection with the Application, constitute the entire agreement between you and us concerning the Application.
''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SNABB BUDGET Application Terms and Conditions',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            for (var section in termsSections)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.heading,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(section.content),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class TermsSection {
  final String heading;
  final String content;

  TermsSection({
    required this.heading,
    required this.content,
  });
}
