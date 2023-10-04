
import 'package:ecart_driver/data/remote/network/response/app_state.dart';

class ApiResponse<T> {
  AppState? appState;
  T? data;
  String? message;

  ApiResponse({
    this.appState,
    this.data,
    this.message,
  });

  ApiResponse.loading() : appState = AppState.onLoading;

  ApiResponse.completed(this.data) : appState = AppState.onSuccess;

  ApiResponse.error(this.message) : appState = AppState.onFailure;

  ApiResponse.empty() : appState = AppState.onEmpty;

  @override
  String toString() {
    return "AppState : $appState \n Message : $message \n Data : $data";
  }
}
