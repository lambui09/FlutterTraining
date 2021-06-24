import 'package:untitled/base/base_bloc.dart';

class MainBloc extends BaseBloc<EmptyState> {
  MainBloc._() : super(EmptyState());

  factory MainBloc() {
    return MainBloc._();
  }

  @override
  void dispose() {}
}
