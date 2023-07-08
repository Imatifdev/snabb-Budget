import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I set up and link my accounts to the app?',
      answer:
          'To set up and link your accounts to a budget app, you\'ll typically need to create an account, connect your bank accounts, and verify your identity. This process may vary depending on the app you\'re using, but most budget apps have a step-by-step process to help you set up and link your accounts.',
    ),
    FAQItem(
      question: 'How do I create a budget and track my spending?',
      answer:
          'Setting spending limits for various categories and keeping track of your transactions as you spend money are normally required in order to construct a budget and keep checks on your spending. The majority of budget applications contain a feature to assist you in setting up a budget and tracking your spending, frequently with the ability to modify categories and examine spending patterns over time.',
    ),
    FAQItem(
      question: 'How often should I update my budget and review my spending?',
      answer:
          'It\'s generally recommended to update your budget and review your spending on a regular basis, such as weekly or monthly. This can help you stay on track with your financial goals and make adjustments as needed.',
    ),
    FAQItem(
      question: 'Can I customize the categories for my expenses?',
      answer:
          'Most budget apps allow users to customize the categories for their expenses, such as adding or removing categories or renaming them to better suit their needs.',
    ),
    FAQItem(
      question: 'Does the app support multiple currencies or accounts?',
      answer:
          'Some budget apps support multiple currencies or accounts, while others may have limitations. Check the app\'s features and settings to see if it supports the currencies or accounts you need.',
    ),
    FAQItem(
      question: 'How secure is my financial information in the app?',
      answer:
          'Most budget apps use encryption and other security measures to protect users\' financial information. However, it\'s important to read the app\'s privacy policy and understand how your information is being stored and used.',
    ),
    FAQItem(
      question:
          'Does the app provide any guidance or recommendations for improving my finances?',
      answer:
          'Some budget apps provide guidance or recommendations for improving your finances, such as identifying areas where you can save money or suggesting ways to increase your income. Check the app\'s features and settings to see if it offers any guidance or recommendations.',
    ),
    FAQItem(
      question:
          'What features or tools does the app offer to help me reach my financial goals?',
      answer:
          'Most budget apps offer a variety of features and tools to help users reach their financial goals, such as setting savings goals, tracking progress, and providing insights and analytics to help users make informed financial decisions. Check the app\'s features and settings to see what tools it offers to help you reach your financial goals.',
    ),
  ];
  final String feedback = '''
Snabb Budget is an app that helps people manage their finances by tracking their income and expenses. It allows you to set budgets, monitor your spending, and receive alerts when you are approaching your budget limits. It also provides helpful insights and analytics to help and make informed financial decisions. With Snabb Budget, you can take control of finances and achieve your financial goals.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                feedback,
                textAlign: TextAlign.justify,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: faqItems.length,
              itemBuilder: (BuildContext context, int index) {
                return FAQTile(
                  faqItem: faqItems[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}

class FAQTile extends StatefulWidget {
  final FAQItem faqItem;

  FAQTile({
    required this.faqItem,
  });

  @override
  _FAQTileState createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          title: Text(
            widget.faqItem.question,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.faqItem.answer),
            ),
          ],
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          initiallyExpanded: _isExpanded,
        ),
      ),
    );
  }
}
