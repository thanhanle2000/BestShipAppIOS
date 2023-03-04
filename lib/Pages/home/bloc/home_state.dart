part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeEmpty extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final bool hasReachedMax;
  final int pageNumber;

  const HomeLoaded({required this.hasReachedMax, this.pageNumber = 1});

  HomeLoaded copyWith({
    bool? hasReachedMax,
    int? pageNumber,
  }) {
    return HomeLoaded(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  List<Object> get props => [hasReachedMax, pageNumber];

  @override
  String toString() =>
      'HomeLoaded { tweets: 0, hasReachedMax: $hasReachedMax }';
}

class HomeError extends HomeState {}

class HomePublishing extends HomeState {}

class HomePublished extends HomeState {
  const HomePublished();

  @override
  List<Object> get props => [];
}

class PublishTweetError extends HomeState {}

class HomeDeleting extends HomeState {}

class HomeDeleted extends HomeState {}

class DeleteHomeError extends HomeState {}
