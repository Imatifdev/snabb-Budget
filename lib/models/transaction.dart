enum TransactionType{income,expense}
enum TransactionCat{moneyTransfer,shopping,taxi,bills}

class Transaction{
  final String name;
  final String time;
  final DateTime date;
  final String imgUrl;
  final TransactionType type;
  final TransactionCat category;
  final int amount;

  Transaction({
    required this.name,
    required this.time,
    required this.date,
    required this.imgUrl,
    required this.type,
    required this.category,
    required this.amount,
  }); 
}

