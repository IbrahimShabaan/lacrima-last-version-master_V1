abstract class SalesStates {}

class SalesInitialState extends SalesStates {}

class SalesBottomNavChangeState extends SalesStates {}

class CustomerIdChangeState extends SalesStates {}

class SalesCurrencyChangeState extends SalesStates {}

// ############# Insert Order States #############
class InsertOrderLoadingState extends SalesStates {}

class InsertOrderSuccessState extends SalesStates {}

class InsertOrderErrorState extends SalesStates {
  final String error;

  InsertOrderErrorState(this.error);
}

// ############# Get Order States #############
class GetOrderLoadingState extends SalesStates {}

class GetOrderSuccessState extends SalesStates {}

class GetOrderErrorState extends SalesStates {
  final String error;

  GetOrderErrorState(this.error);
}

// ############# Get Order States #############
class GetOrderByIdLoadingState extends SalesStates {}

class GetOrderByIdSuccessState extends SalesStates {}

class GetOrderByIdErrorState extends SalesStates {
  final String error;

  GetOrderByIdErrorState(this.error);
}

// ############# Update Order States #############
class UpdateTrackOrderLoadingState extends SalesStates {}

class UpdateTrackOrderSuccessState extends SalesStates {}

class UpdateTrackOrderErrorState extends SalesStates {
  final String error;

  UpdateTrackOrderErrorState(this.error);
}

// ############# Update Order States #############
class UpdateOrderLoadingState extends SalesStates {}

class UpdateOrderSuccessState extends SalesStates {}

class UpdateOrderErrorState extends SalesStates {
  final String error;

  UpdateOrderErrorState(this.error);
}

// ############# Delete Order States #############
class DeleteOrderLoadingState extends SalesStates {}

class DeleteOrderSuccessState extends SalesStates {}

class DeleteOrderErrorState extends SalesStates {
  final String error;

  DeleteOrderErrorState(this.error);
}

// ############# Employee Picked Order Image States #############
class SalesPickedOrderImageLoadingState extends SalesStates {}

class SalesPickedOrderImageSuccessState extends SalesStates {}

class SalesPickedOrderImageErrorState extends SalesStates {}

// ############# Employee Upload Order Image States #############
class SalesUploadOrderImageLoadingState extends SalesStates {}

class SalesUploadOrderImageSuccessState extends SalesStates {}

class SalesUploadOrderImageErrorState extends SalesStates {}

// ############# Employee Upload Order Image States #############
class SalesUploadMultiImageOrderLoadingState extends SalesStates {}

class SalesUploadMultiImageOrderSuccessState extends SalesStates {}

class SalesUploadMultiImageOrderErrorState extends SalesStates {}

// ############# Employee Set Order Image States #############
class SalesSetOrderImageLoadingState extends SalesStates {}

class SalesSetOrderImageSuccessState extends SalesStates {}

class SalesSetOrderImageErrorState extends SalesStates {
  final String error;

  SalesSetOrderImageErrorState(this.error);
}

class DeleteComplaintsOrSuggestionsLoadingState extends SalesStates {}

class DeleteComplaintsOrSuggestionsSuccessState extends SalesStates {}

class DeleteComplaintsOrSuggestionsErrorState extends SalesStates {
  final String error;

  DeleteComplaintsOrSuggestionsErrorState(this.error);
}

class DeleteFeedBackLoadingState extends SalesStates {}

class DeleteFeedBackSuccessState extends SalesStates {}

class DeleteFeedBackErrorState extends SalesStates {
  final String error;

  DeleteFeedBackErrorState(this.error);
}

class CloseImageChangeState extends SalesStates {}

class OrderTrackChangeState extends SalesStates {}

class IncrementQuantityChangeState extends SalesStates {}

class DecrementQuantityChangeState extends SalesStates {}

class CheckBoxChangeState extends SalesStates {}
