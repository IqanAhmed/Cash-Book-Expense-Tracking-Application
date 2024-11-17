class Logs {
  String id;
  String transactionId;
  String? iconId;
  String? title;
  String? description;
  String? amount;
  String? time;
  String? date;
  int isIconId;
  int isTitle;
  int isDescription;
  int isAmount;
  int isTime;
  int isDate;
  String action;  

  Logs({
    required this.id,
    required this.transactionId,
    this.iconId,
    this.title,
    this.description,
    this.amount,
    this.time,
    this.date,
    required this.isIconId,
    required this.isTitle,
    required this.isDescription,
    required this.isAmount,
    required this.isTime,
    required this.isDate,
    required this.action,  // Updated in constructor
  });

  // Factory constructor to create an instance from a map
  factory Logs.fromMap(Map<String, dynamic> json) => Logs(
        id: json['LogID'],
        transactionId: json['TransactionID'],
        iconId: json['IconID'],
        title: json['Title'],
        description: json['Description'],
        amount: json['Amount'],
        time: json['Time'],
        date: json['Date'],
        isIconId: json['isIconID'],
        isTitle: json['isTitle'],
        isDescription: json['isDescription'],
        isAmount: json['isAmount'],
        isTime: json['isTime'],
        isDate: json['isDate'],
        action: json['Action'],  // Extract from JSON
      );

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'LogID': id,
      'TransactionID': transactionId,
      'IconID': iconId,
      'Title': title,
      'Description': description,
      'Amount': amount,
      'Time': time,
      'Date': date,
      'isIconID': isIconId,
      'isTitle': isTitle,
      'isDescription': isDescription,
      'isAmount': isAmount,
      'isTime': isTime,
      'isDate': isDate,
      'Action': action,  // Add to the map
    };
  }
}
