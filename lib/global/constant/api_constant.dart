// lib/global/constant/api_constant.dart

class ApiConstants {
  // Base URL
  static const String baseUrl = "https://world-api-stg.iywt.com/api";

  // Auth Endpoints
  static const String login = "/Auth/login";
  static const String register = "/Auth/register";
  static const String forgotPassword = "/Auth/forgot-password";

  // Home/Dashboard Endpoints
  static const String dashboard = "/LongTermStudent/Dashboard";

  // Legal Entry Endpoints
  static const String legalEntryBasics = "/LongTermStudent/LegalEntryBasics";

  // Student Information Endpoints
  static const String studentInformation = "/LongTermStudent/StudentInformation";

  // Student Addresses Endpoints
  static const String studentAddresses = "/LongTermStudent/StudentAddresses";
  static String studentAddressById(String id) => "/LongTermStudent/StudentAddresses/$id";

  // Student Emails Endpoints
  static const String studentEmails = "/LongTermStudent/StudentEmails";
  static String studentEmailById(String id) => "/LongTermStudent/StudentEmails/$id";

  // Student Phones Endpoints
  static const String studentPhones = "/LongTermStudent/StudentPhones";
  static String studentPhoneById(String id) => "/LongTermStudent/StudentPhones/$id";

  // Technical Support Endpoint
  static const String technicalSupport = "/General/TechnicalSupport";

  // Documents Endpoints
  static const String documentsDashboard = "/LongTermStudent/DocumentsDashboard";
  static String documentTypeList(String type) => "/LongTermStudent/DocumentTypeList/$type";
  static String documentDetail(String id) => "/LongTermStudent/DocumentDetail/$id";
  static String documentUpload(String id) => "/LongTermStudent/DocumentUpload/$id";
}