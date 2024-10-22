abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

class InsertProductLoadingState extends ProductStates {}

class InsertProductSuccessState extends ProductStates {}

class InsertProductErrorState extends ProductStates {
  final String error;

  InsertProductErrorState(this.error);
}

class GetProductLoadingState extends ProductStates {}

class GetProductSuccessState extends ProductStates {}

class GetProductErrorState extends ProductStates {
  final String error;

  GetProductErrorState(this.error);
}

class UpdateProductLoadingState extends ProductStates {}

class UpdateProductSuccessState extends ProductStates {}

class UpdateProductErrorState extends ProductStates {
  final String error;

  UpdateProductErrorState(this.error);
}

class DeleteProductLoadingState extends ProductStates {}

class DeleteProductSuccessState extends ProductStates {}

class DeleteProductErrorState extends ProductStates {
  final String error;

  DeleteProductErrorState(this.error);
}

class PickedProductImageLoadingState extends ProductStates {}

class PickedProductImageSuccessState extends ProductStates {}

class PickedProductImageErrorState extends ProductStates {}

class UploadProductImageLoadingState extends ProductStates {}

class UploadProductImageSuccessState extends ProductStates {}

class UploadProductImageErrorState extends ProductStates {
  final String error;

  UploadProductImageErrorState(this.error);
}

class SetProductImageLoadingState extends ProductStates {}

class SetProductImageSuccessState extends ProductStates {}

class SetProductImageErrorState extends ProductStates {
  final String error;

  SetProductImageErrorState(this.error);
}

class NationalityProductsState extends ProductStates {}

class CloseImageChangeState extends ProductStates {}
