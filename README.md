# iywt folder structure

lib
├── main.dart
├── core
│   ├── custom_assets
│   │  
│   ├── network
│   │   └── connection_checker.dart
│   ├── routes
│   │   ├── routes.dart
│   │   ├── route_observer.dart
│   │   └── route_path.dart
│   └── theme
│
│
├── global
│   ├── constant
│   │   └── api_constant.dart
│   ├── service
│   │   ├── api_services.dart
│   │   ├── auth
│   │   │   ├── login_service.dart
│   │   │   ├── forget_password_service.dart
│   │   │   ├── forget_password_otp_service.dart
│   │   │   └── password_reset_service.dart
│   │   ├── home
│   │   │   └── home_service.dart
│   │   ├── legal_entry_basic
│   │   │   └── legal_entry_basic_service.dart
│   │   ├── documents
│   │   │   ├── documents_service.dart
│   │   │   ├── preliminary_service.dart
│   │   │   ├── student_service.dart
│   │   │   ├── country_service.dart
│   │   │   ├── passport_service.dart
│   │   │   ├── scanner_service.dart
│   │   │   └── edit_service.dart
│   │   ├── massage
│   │   │   └── massage_service.dart
│   │   ├── settings
│   │   │   ├── settings_service.dart
│   │   │   ├── student_information_service.dart
│   │   │   ├── address_service.dart
│   │   │   ├── add_address_service.dart
│   │   │   ├── email_service.dart
│   │   │   ├── add_email_service.dart
│   │   │   ├── phone_service.dart
│   │   │   ├── add_phone_service.dart
│   │   │   ├── address_service.dart
│   │   │   ├── add_address_service.dart
│   │   │   ├── change_password_service.dart
│   │   │   └── tecnical_support_service.dart
│   │   └── notification
│   │       └── notification_service.dart
│   ├── controler
│   │   ├── auth
│   │   │   ├── login_controler.dart
│   │   │   ├── forget_password_controler.dart
│   │   │   ├── forget_password_otp_controler.dart
│   │   │   └── password_reset_controler.dart
│   │   ├── home
│   │   │   └── home_controler.dart
│   │   ├── legal_entry_basic
│   │   │   └── legal_entry_basic_controler.dart
│   │   ├── documents
│   │   │   ├── documents_controler.dart
│   │   │   ├── preliminary_controler.dart
│   │   │   ├── student_controler.dart
│   │   │   ├── country_controler.dart
│   │   │   ├── passport_controler.dart
│   │   │   ├── scanner_controler.dart
│   │   │   └── edit_controler.dart
│   │   ├── massage
│   │   │   └── massage_controler.dart
│   │   ├── settings
│   │   │   ├── settings_controler.dart
│   │   │   ├── student_information_controler.dart
│   │   │   ├── address_controler.dart
│   │   │   ├── add_address_controler.dart
│   │   │   ├── email_controler.dart
│   │   │   ├── add_email_controler.dart
│   │   │   ├── phone_controler.dart
│   │   │   ├── add_phone_controler.dart
│   │   │   ├── address_controler.dart
│   │   │   ├── add_address_controler.dart
│   │   │   ├── change_password_controler.dart
│   │   │   └── tecnical_support_controler.dart
│   │   └── notification
│   │       └── notification_controler.dart
│   ├── model
│   │   ├── home
│   │   │   └── home_model.dart
│   │   ├── legal_entry_basic
│   │   │   └── legal_entry_basic_model.dart
│   │   ├── documents
│   │   │   ├── documents_model.dart
│   │   │   ├── preliminary_model.dart
│   │   │   ├── student_model.dart
│   │   │   ├── country_model.dart
│   │   │   ├── passport_model.dart
│   │   │   ├── scanner_model.dart
│   │   │   └── edit_model.dart
│   │   ├── massage
│   │   │   └── massage_model.dart
│   │   ├── settings
│   │   │   ├── settings_model.dart
│   │   │   ├── student_information_model.dart
│   │   │   ├── address_model.dart
│   │   │   ├── add_address_model.dart
│   │   │   ├── email_model.dart
│   │   │   ├── add_email_model.dart
│   │   │   ├── phone_model.dart
│   │   │   ├── add_phone_model.dart
│   │   │   ├── address_model.dart
│   │   │   ├── add_address_model.dart
│   │   │   ├── change_password_model.dart
│   │   │   └── tecnical_support_model.dart
│   │   └── notification
│   │       └── notification_model.dart
│   └── storage
│        └── storage_helper.dart
│
│
└── presentation
    ├── screens
    │   ├── onbording
    │   │   └── onboarding.dart
    │   │
    │   ├── authentication 
    │   │   ├── login.dart
    │   │   ├── forget_password.dart
    │   │   ├── forget_password_otp.dart
    │   │   ├── reset_password.dart  
    │   │   └── reset_password_success.dart
    │   │
    │   ├── home   
    │   │   └── home.dart
    │   │       
    │   │
    │   ├── legal_entry_basic    
    │   │   └── destination.dart
    │   │
    │   ├── documents_screen    
    │   │   ├── documents.dart
    │   │   ├── preliminary.dart
    │   │   ├── student.dart
    │   │   ├── country.dart
    │   │   ├── passport.dart   
    │   │   ├── scanner.dart
    │   │   └── edit.dart
    │   │
    │   ├── massage_screen
    │   │   └── massage_screen.dart
    │   │
    │   ├── settings
    │   │   ├── settings.dart
    │   │   ├── my_infomation.dart
    │   │   ├── student_information.dart
    │   │   ├── address.dart
    │   │   ├── add_address.dart
    │   │   ├── email.dart
    │   │   ├── add_email.dart
    │   │   ├── phone.dart
    │   │   ├── add_phone.dart
    │   │   ├── address.dart
    │   │   ├── add_address.dart
    │   │   ├── change_password.dart
    │   │   ├── tecnical_support.dart
    │   │   └── privacy_polcy.dart
    │   │
    │   └── notification
    │       └── notification.dart
    │    
    │
    └── widgets
        └── custom_navigation
            └── custom_navbar.dart



