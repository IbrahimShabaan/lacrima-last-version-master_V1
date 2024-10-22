abstract class HRStates {}

class HRInitialState extends HRStates {}

class HRBottomNavChangeState extends HRStates {}

class DeleteJobLoadingState extends HRStates {}

class DeleteJobSuccessState extends HRStates {}

class DeleteJobErrorState extends HRStates {
  final String error;

  DeleteJobErrorState(this.error);
}

class DeletePDFJobLoadingState extends HRStates {}

class DeletePDFJobSuccessState extends HRStates {}

class DeletePDFJobErrorState extends HRStates {
  final String error;

  DeletePDFJobErrorState(this.error);
}

class DeleteFeedBackLoadingState extends HRStates {}

class DeleteFeedBackSuccessState extends HRStates {}

class DeleteFeedBackErrorState extends HRStates {
  final String error;

  DeleteFeedBackErrorState(this.error);
}
