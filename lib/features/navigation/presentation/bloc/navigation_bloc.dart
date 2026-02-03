import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_bloc.freezed.dart';

@freezed
sealed class NavigationEvent with _$NavigationEvent {
  const factory NavigationEvent.pageChanged(int index) = PageChanged;
}

@freezed
sealed class NavigationState with _$NavigationState {
  const factory NavigationState({
    @Default(0) int pageIndex,
  }) = _NavigationState;
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const _NavigationState()) {
    on<PageChanged>((event, emit) {
      emit(state.copyWith(pageIndex: event.index));
    });
  }
}
