import 'package:rick_morty_effective/core/bloc/app_cubit.dart';

mixin StartStopLoading {
  AppCubit get appBloc;

  void startLoading() {
    appBloc.setLoadingStatus(WidgetStatus.loading);
  }

  void stopLoading() {
    appBloc.setLoadingStatus(WidgetStatus.content);
  }
}
