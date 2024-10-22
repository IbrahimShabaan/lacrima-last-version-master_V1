abstract class CustomerStates {}

class CustomerInitialState extends CustomerStates {}

// ####################### Customer SignUp ##########################
class CustomerSignUpLoadingState extends CustomerStates {}

class CustomerSignUpSuccessState extends CustomerStates {}

class CustomerSignUpErrorState extends CustomerStates {
  final String error;

  CustomerSignUpErrorState(this.error);
}

// ####################### Customer Reset Password ##########################
class CustomerResetPasswordLoadingState extends CustomerStates {}

class CustomerResetPasswordSuccessState extends CustomerStates {}

class CustomerResetPasswordErrorState extends CustomerStates {
  final String error;

  CustomerResetPasswordErrorState(this.error);
}

// ####################### Customer SignIn ##########################
class CustomerSignInLoadingState extends CustomerStates {}

class CustomerSignInSuccessState extends CustomerStates {
  final String id;

  CustomerSignInSuccessState(this.id);
}

class CustomerSignInErrorState extends CustomerStates {
  final String error;

  CustomerSignInErrorState(this.error);
}

// ####################### Customer SignIn ##########################
class CustomerSignOutLoadingState extends CustomerStates {}

class CustomerSignOutSuccessState extends CustomerStates {}

class CustomerSignOutErrorState extends CustomerStates {
  final String error;

  CustomerSignOutErrorState(this.error);
}

// ############ Insert Customer States ############
class InsertCustomerLoadingState extends CustomerStates {}

class InsertCustomerSuccessState extends CustomerStates {
  final String id;

  InsertCustomerSuccessState(this.id);
}

class InsertCustomerErrorState extends CustomerStates {
  final String error;

  InsertCustomerErrorState(this.error);
}

// ############ Get Customer States ############
class GetCustomerLoadingState extends CustomerStates {}

class GetCustomerSuccessState extends CustomerStates {}

class GetCustomerErrorState extends CustomerStates {
  final String error;

  GetCustomerErrorState(this.error);
}

// ############ Update Customer States ############
class UpdateCustomerLoadingState extends CustomerStates {}

class UpdateCustomerSuccessState extends CustomerStates {}

class UpdateCustomerErrorState extends CustomerStates {
  final String error;

  UpdateCustomerErrorState(this.error);
}

// ############ Update Customer States ############
class SetCustomerTokenLoadingState extends CustomerStates {}

class SetCustomerTokenSuccessState extends CustomerStates {}

class SetCustomerTokenErrorState extends CustomerStates {
  final String error;

  SetCustomerTokenErrorState(this.error);
}

// ############# Employee Picked Profile Image Sates #############
class PickedProfileImageLoadingState extends CustomerStates {}

class PickedProfileImageSuccessState extends CustomerStates {}

class PickedProfileImageErrorState extends CustomerStates {}

// ############# Employee Upload Profile Image Sates #############
class UploadProfileImageLoadingState extends CustomerStates {}

class UploadProfileImageSuccessState extends CustomerStates {}

class UploadProfileImageErrorState extends CustomerStates {}

// ############# Employee Set Profile Image Sates #############
class SetProfileImageLoadingState extends CustomerStates {}

class SetProfileImageSuccessState extends CustomerStates {}

class CloseImageChangeState extends CustomerStates {}

class SetProfileImageErrorState extends CustomerStates {
  final String error;

  SetProfileImageErrorState(this.error);
}

class CustomerBottomNavChangeState extends CustomerStates {}

class CustomerChangeRadioButton extends CustomerStates {}

class CustomerZoomChangeState extends CustomerStates {}

class CustomerJumpChangeState extends CustomerStates {}

class EnquirySelectTypeChangeState extends CustomerStates {}

// ############ Insert Complaints And Suggestion States ############
class InsertComplaintsAndSuggestionLoadingState extends CustomerStates {}

class InsertComplaintsAndSuggestionSuccessState extends CustomerStates {}

class InsertComplaintsAndSuggestionErrorState extends CustomerStates {
  final String error;

  InsertComplaintsAndSuggestionErrorState(this.error);
}

class InsertFeedbackLoadingState extends CustomerStates {}

class InsertFeedbackSuccessState extends CustomerStates {}

class InsertFeedbackErrorState extends CustomerStates {
  final String error;

  InsertFeedbackErrorState(this.error);
}

class ApplyYourJobDropDownChangeState extends CustomerStates {}

class ClearFileSelectChangeState extends CustomerStates {}

class UploadCVPDfLoadingState extends CustomerStates {}

class UploadCVPDfSuccessState extends CustomerStates {}

class UploadCVPDfErrorState extends CustomerStates {
  final String error;

  UploadCVPDfErrorState(this.error);
}

class InsertJobLoadingState extends CustomerStates {}

class InsertJobSuccessState extends CustomerStates {}

class InsertJobErrorState extends CustomerStates {
  final String error;

  InsertJobErrorState(this.error);
}

class SetCVPDfLoadingState extends CustomerStates {}

class SetCVPDfSuccessState extends CustomerStates {}

class SetCVPDfErrorState extends CustomerStates {
  final String error;

  SetCVPDfErrorState(this.error);
}

class DeleteCustomerLoadingState extends CustomerStates {}

class DeleteCustomerSuccessState extends CustomerStates {}

class DeleteCustomerErrorState extends CustomerStates {
  final String error;

  DeleteCustomerErrorState(this.error);
}

