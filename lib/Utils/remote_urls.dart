class RemoteUrls {
  static const baseUrl = "https://fastquote.co.in/cashpro/mobileAppApi";
  static String imageUrl = "https://fastquote.co.in/cashpro";

  static String loginUrl = "$baseUrl/login";

  // * Technician
  static String getProfile = "$baseUrl/technician-list?tech_id";
  static String getRechargeData = "$baseUrl/technician-pass-recharge?tech_id";
  static String getClaimSheetAmt =
      "$baseUrl/technician-claim-sheet-pending?tech_id";
  static String technicianAllExpense =
      "$baseUrl/technician-all-expense?tech_id";
  static String profileUpdate = "$baseUrl/profile-update";
  static String serviceTicketValidate =
      "$baseUrl/service-ticket-no-validate?type=";

  static String getClaimSheet = "$baseUrl/technician-claim-sheet-list?tech_id=";
  static String addClaimSheet = "$baseUrl/add-technician-claim-sheet";
  static String getClaimSheetReciept = "$baseUrl/technician-claim-sheet-maxid";
  static String editClaimSheetReciept = "$baseUrl/edit-technician-claim-sheet";

  static String technicianProductList =
      "$baseUrl/technician-product-list?tech_id=";
  static String technicianPartList = "$baseUrl/technician-part-list?tech_id=";

  static String getExpenseSheet = "$baseUrl/technician-expense-list?tech_id=";
  static String addExpense = "$baseUrl/add-technician-expense";
  static String getProblemList = "$baseUrl/problem-list";
  static String editExpense = "$baseUrl/edit-technician-expense";

  static String technicianStockList = "$baseUrl/technician-stock-list?tech_id=";

  static String techHistory = "$baseUrl/technician-payment-history?tech_id=";
  static String techLoanHistory = "$baseUrl/technician-loan-return?tech_id=";

  static String getManualsList = "$baseUrl/manual-list";
  static String appVersion = "$baseUrl/app-version";
}
