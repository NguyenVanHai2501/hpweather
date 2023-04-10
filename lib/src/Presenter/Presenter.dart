import 'package:weather/src/Contract/viewContract.dart';

class Presenter<T extends ViewContract> {
  late T view;

  attachView(T view) {
    this.view = view;
  }

  T getView() {
    return view;
  }
}