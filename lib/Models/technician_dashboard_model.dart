class TechnicianDashboardExpenseModel {
  final String? officeWallet;
  final String? approvedExpense;
  final String? balanceExpense;
  final String? loan;
  final String? loanReturn;
  final String? loanBalance;

  TechnicianDashboardExpenseModel({
    this.officeWallet,
    this.approvedExpense,
    this.balanceExpense,
    this.loan,
    this.loanReturn,
    this.loanBalance,
  });

  factory TechnicianDashboardExpenseModel.fromJson(Map<String, dynamic> json) {
    double balanceLoan = 0.0, balExpense = 0.0;
    if (json["loan"] != null && json["loan_return"] != null) {
      balanceLoan =
          double.parse(json["loan"]) - double.parse(json["loan_return"]);
    }

    if (json["office_wallet"] != null && json["approved_expense"] != null) {
      balExpense = double.parse(json["office_wallet"]) -
          double.parse(json["approved_expense"]);
    }
    return TechnicianDashboardExpenseModel(
      officeWallet: json["office_wallet"],
      approvedExpense: json["approved_expense"],
      balanceExpense: balExpense.toStringAsFixed(2),
      loan: json["loan"],
      loanReturn: json["loan_return"],
      loanBalance: balanceLoan.toStringAsFixed(2),
    );
  }
}
