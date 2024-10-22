abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

class InsertAnnouncementLoadingState extends AdminStates {}

class InsertAnnouncementSuccessState extends AdminStates {}

class InsertAnnouncementErrorState extends AdminStates {
  final String error;

  InsertAnnouncementErrorState(this.error);
}

class PickedAnnouncementImageLoadingState extends AdminStates {}

class PickedAnnouncementImageSuccessState extends AdminStates {}

class PickedAnnouncementImageErrorState extends AdminStates {}

class UploadAnnouncementImageLoadingState extends AdminStates {}

class UploadAnnouncementImageSuccessState extends AdminStates {}

class UploadAnnouncementImageErrorState extends AdminStates {
  final String error;

  UploadAnnouncementImageErrorState(this.error);
}

class SetAnnouncementImageLoadingState extends AdminStates {}

class SetAnnouncementImageSuccessState extends AdminStates {}

class SetAnnouncementImageErrorState extends AdminStates {
  final String error;

  SetAnnouncementImageErrorState(this.error);
}

class DeleteAnnouncementImageLoadingState extends AdminStates {}

class DeleteAnnouncementImageSuccessState extends AdminStates {}

class DeleteAnnouncementImageErrorState extends AdminStates {
  final String error;

  DeleteAnnouncementImageErrorState(this.error);
}

class DeleteAnnouncementLoadingState extends AdminStates {}

class DeleteAnnouncementSuccessState extends AdminStates {}

class DeleteAnnouncementErrorState extends AdminStates {
  final String error;

  DeleteAnnouncementErrorState(this.error);
}

class DeleteComplaintsOrSuggestionsLoadingState extends AdminStates {}

class DeleteComplaintsOrSuggestionsSuccessState extends AdminStates {}

class DeleteComplaintsOrSuggestionsErrorState extends AdminStates {
  final String error;

  DeleteComplaintsOrSuggestionsErrorState(this.error);
}

class DeleteJobLoadingState extends AdminStates {}

class DeleteJobSuccessState extends AdminStates {}

class DeleteJobErrorState extends AdminStates {
  final String error;

  DeleteJobErrorState(this.error);
}

class DeletePDFJobLoadingState extends AdminStates {}

class DeletePDFJobSuccessState extends AdminStates {}

class DeletePDFJobErrorState extends AdminStates {
  final String error;

  DeletePDFJobErrorState(this.error);
}

class DeleteFeedBackLoadingState extends AdminStates {}

class DeleteFeedBackSuccessState extends AdminStates {}

class DeleteFeedBackErrorState extends AdminStates {
  final String error;

  DeleteFeedBackErrorState(this.error);
}





class AdminSelectNationalityProductsState extends AdminStates {}

class AdminBottomNavChangeState extends AdminStates {}

class AdminCloseImageChangeState extends AdminStates {}

class EmployeeChangeRadioButton extends AdminStates {}
