abstract class GuestStates {}

class GuestInitialState extends GuestStates {}

class BottomNavChangeState extends GuestStates {}

class ApplyYourJobDropDownChangeState extends GuestStates {}

class ClearFileSelectChangeState extends GuestStates {}

class UploadCVPDfLoadingState extends GuestStates {}

class UploadCVPDfSuccessState extends GuestStates {}

class UploadCVPDfErrorState extends GuestStates {
  final String error;

  UploadCVPDfErrorState(this.error);
}

class InsertJobLoadingState extends GuestStates {}

class InsertJobSuccessState extends GuestStates {}

class InsertJobErrorState extends GuestStates {
  final String error;

  InsertJobErrorState(this.error);
}

class SetCVPDfLoadingState extends GuestStates {}

class SetCVPDfSuccessState extends GuestStates {}

class SetCVPDfErrorState extends GuestStates {
  final String error;

  SetCVPDfErrorState(this.error);
}

class InsertFeedbackLoadingState extends GuestStates {}

class InsertFeedbackSuccessState extends GuestStates {}

class InsertFeedbackErrorState extends GuestStates {
  final String error;

  InsertFeedbackErrorState(this.error);
}
