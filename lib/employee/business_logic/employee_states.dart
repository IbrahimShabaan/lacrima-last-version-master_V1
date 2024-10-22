abstract class EmployeeStates {}

class EmployeeInitialState extends EmployeeStates {}

// ############ Insert Employee States ############
class InsertEmployeeLoadingState extends EmployeeStates {}

class InsertEmployeeSuccessState extends EmployeeStates {}

class InsertEmployeeErrorState extends EmployeeStates {
  final String error;

  InsertEmployeeErrorState(this.error);
}

// ############ Get Employee States ############
class GetEmployeeLoadingState extends EmployeeStates {}

class GetEmployeeSuccessState extends EmployeeStates {}

class GetEmployeeErrorState extends EmployeeStates {
  final String error;

  GetEmployeeErrorState(this.error);
}

// ############ Get All Employee States ############
class GetAllEmployeeLoadingState extends EmployeeStates {}

class GetAllEmployeeSuccessState extends EmployeeStates {}

class GetAllEmployeeErrorState extends EmployeeStates {
  final String error;

  GetAllEmployeeErrorState(this.error);
}

// ############ Update Employee States ############
class UpdateEmployeeLoadingState extends EmployeeStates {}

class UpdateEmployeeSuccessState extends EmployeeStates {}

class UpdateEmployeeErrorState extends EmployeeStates {
  final String error;

  UpdateEmployeeErrorState(this.error);
}

// ############ Update Vacation Employee States ############
class UpdateVacationEveryYearLoadingState extends EmployeeStates {}

class UpdateVacationEveryYearSuccessState extends EmployeeStates {}

class UpdateVacationEveryYearErrorState extends EmployeeStates {
  final String error;

  UpdateVacationEveryYearErrorState(this.error);
}

// ############ Delete Employee States ############
class DeleteEmployeeLoadingState extends EmployeeStates {}

class DeleteEmployeeSuccessState extends EmployeeStates {}

class DeleteEmployeeErrorState extends EmployeeStates {
  final String error;

  DeleteEmployeeErrorState(this.error);
}

// ############ Delete Employee States ############
class DeleteEmployeeSalaryLoadingState extends EmployeeStates {}

class DeleteEmployeeSalarySuccessState extends EmployeeStates {}

class DeleteEmployeeSalaryErrorState extends EmployeeStates {
  final String error;

  DeleteEmployeeSalaryErrorState(this.error);
}

class EmployeeBottomNavChangeState extends EmployeeStates {}

class EmployeeDropDownChangeState extends EmployeeStates {}

class EmployeeChangeRadioButton extends EmployeeStates {}

class SelectMonthFinancialSheetState extends EmployeeStates {}

// ############ Insert Salary Employee States ############
class InsertSalaryEmployeeLoadingState extends EmployeeStates {}

class InsertSalaryEmployeeSuccessState extends EmployeeStates {}

class InsertSalaryEmployeeErrorState extends EmployeeStates {
  final String error;

  InsertSalaryEmployeeErrorState(this.error);
}

// ############ Get Salary Employee States ############
class GetSalaryEmployeeLoadingState extends EmployeeStates {}

class GetSalaryEmployeeSuccessState extends EmployeeStates {}

class GetSalaryEmployeeErrorState extends EmployeeStates {
  final String error;

  GetSalaryEmployeeErrorState(this.error);
}

// ############ Update Salary Employee States ############
class UpdateSalaryEmployeeLoadingState extends EmployeeStates {}

class UpdateSalaryEmployeeSuccessState extends EmployeeStates {}

class UpdateSalaryEmployeeErrorState extends EmployeeStates {
  final String error;

  UpdateSalaryEmployeeErrorState(this.error);
}

// ####################### Employee SignUp ##########################
class EmployeeSignUpLoadingState extends EmployeeStates {}

class EmployeeSignUpSuccessState extends EmployeeStates {}

class EmployeeSignUpErrorState extends EmployeeStates {
  final String error;

  EmployeeSignUpErrorState(this.error);
}

// ####################### Employee SignIn ##########################
class EmployeeSignInLoadingState extends EmployeeStates {}

class EmployeeSignInSuccessState extends EmployeeStates {
  final String empId;

  EmployeeSignInSuccessState(this.empId);
}

class EmployeeSignInErrorState extends EmployeeStates {
  final String error;

  EmployeeSignInErrorState(this.error);
}

// ####################### Employee SignIn ##########################
class EmployeeSignOutLoadingState extends EmployeeStates {}

class EmployeeSignOutSuccessState extends EmployeeStates {}

class EmployeeSignOutErrorState extends EmployeeStates {
  final String error;

  EmployeeSignOutErrorState(this.error);
}

// ############# Employee Picked Profile Image Sates #############
class PickedProfileImageLoadingState extends EmployeeStates {}

class PickedProfileImageSuccessState extends EmployeeStates {}

class PickedProfileImageErrorState extends EmployeeStates {}

// ############# Employee Upload Profile Image Sates #############
class UploadProfileImageLoadingState extends EmployeeStates {}

class UploadProfileImageSuccessState extends EmployeeStates {}

class UploadProfileImageErrorState extends EmployeeStates {}

// ############# Employee Set Profile Image Sates #############
class SetProfileImageLoadingState extends EmployeeStates {}

class SetProfileImageSuccessState extends EmployeeStates {}

class SetProfileImageErrorState extends EmployeeStates {
  final String error;

  SetProfileImageErrorState(this.error);
}

class CloseImageChangeState extends EmployeeStates {}

class EnquirySelectTypeChangeState extends EmployeeStates {}

// ############ Insert Salary Employee States ############
class InsertComplaintsAndSuggestionLoadingState extends EmployeeStates {}

class InsertComplaintsAndSuggestionSuccessState extends EmployeeStates {}

class InsertComplaintsAndSuggestionErrorState extends EmployeeStates {
  final String error;

  InsertComplaintsAndSuggestionErrorState(this.error);
}

// ############ Get Complaints And Suggestion States ############
class GetComplaintsAndSuggestionLoadingState extends EmployeeStates {}

class GetComplaintsAndSuggestionSuccessState extends EmployeeStates {}

class GetComplaintsAndSuggestionErrorState extends EmployeeStates {
  final String error;

  GetComplaintsAndSuggestionErrorState(this.error);
}

// ############ Get Salary Employee States ############
class SetEmployeeTokenLoadingState extends EmployeeStates {}

class SetEmployeeTokenSuccessState extends EmployeeStates {}

class SetEmployeeTokenErrorState extends EmployeeStates {
  final String error;

  SetEmployeeTokenErrorState(this.error);
}
