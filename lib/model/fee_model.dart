class FeeModel {

  String schoolName;
  String campus;
  String accountNo;
  String bankName;
  String issueDate;
  String dueDate;
  String studentName;
  String className;

  List<InvoiceData> invoicesList;

  FeeModel({required this.schoolName, required  this.campus, required  this.accountNo, required  this.bankName,
    required this.issueDate, required  this.dueDate, required  this.studentName,
    required  this.className, required  this.invoicesList});

}

class InvoiceData {

  String invoiceId;
  String description;
  String amount;

  InvoiceData({required this.invoiceId, required  this.description, required  this.amount});

}