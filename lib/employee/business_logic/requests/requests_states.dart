abstract class RequestsStates {}

class RequestsEmployeeInitialState extends RequestsStates {}

// ################## Insert Requests States ##################
class InsertRequestsLoadingState extends RequestsStates {}

class InsertRequestsSuccessState extends RequestsStates {}

class InsertRequestsErrorState extends RequestsStates {
  final String error;

  InsertRequestsErrorState(this.error);
}

// ################## Get Employee All Requests States ##################

class GetAllRequestsLoadingState extends RequestsStates {}

class GetAllRequestsSuccessState extends RequestsStates {}

class GetAllRequestsErrorState extends RequestsStates {
  final String error;

  GetAllRequestsErrorState(this.error);
}
// ################## Get Employee Requests By Id States ##################

class GetRequestsByIdLoadingState extends RequestsStates {}

class GetRequestsByIdSuccessState extends RequestsStates {}

class GetRequestsByIdErrorState extends RequestsStates {
  final String error;

  GetRequestsByIdErrorState(this.error);
}

// ################## Update Employee Requests By Id States ##################

class UpdateRequestsLoadingState extends RequestsStates {}

class UpdateRequestsSuccessState extends RequestsStates {}

class UpdateRequestsErrorState extends RequestsStates {
  final String error;

  UpdateRequestsErrorState(this.error);
}

// ################## Update Employee Requests By Id States ##################

class DeleteRequestsLoadingState extends RequestsStates {}

class DeleteRequestsSuccessState extends RequestsStates {}

class DeleteRequestsErrorState extends RequestsStates {
  final String error;

  DeleteRequestsErrorState(this.error);
}

// ############ Update Vacation Employee States ############
class UpdateVacationLoadingState extends RequestsStates {}

class UpdateVacationSuccessState extends RequestsStates {}

class UpdateVacationErrorState extends RequestsStates {
  final String error;

  UpdateVacationErrorState(this.error);
}

// #############################################################################
class DropDownButtonChange extends RequestsStates {}

class LeaveTypeChange extends RequestsStates {}

class VacationTypeChange extends RequestsStates {}

class OverTimeTypeChange extends RequestsStates {}

class IsAcceptChange extends RequestsStates {}
