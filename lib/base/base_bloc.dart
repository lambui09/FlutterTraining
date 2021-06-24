import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<T extends BaseState> extends BlocBase<T> {
  BaseBloc(T state) : super(state);

  void dispose();
}

abstract class BaseState {}

class EmptyState extends BaseState {}

class LoadingState extends BaseState {}
