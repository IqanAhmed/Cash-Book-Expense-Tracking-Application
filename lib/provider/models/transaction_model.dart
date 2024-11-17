class Transactions {
  String id;
  int iconId;
  String title;
  String description;
  num amount;
  String time;
  String date;
  Transactions({
    required this.id,
    required this.iconId,
    required this.title,
    required this.description,
    required this.amount,
    required this.time,
    required this.date,
  });

// Implementing The Map Structure

  factory Transactions.fromMap(Map<String, dynamic> json) => Transactions(
        id: json['ID'],
        iconId: json['IconID'],
        title: json['Title'],
        description: json['Description'],
        amount: json['Amount'],
        time: json['Time'],
        date: json['Date'],
      );

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'IconID': iconId,
      'Title': title,
      'Description': description,
      'Amount': amount,
      'Time': time,
      'Date': date,
    };
  }
}
