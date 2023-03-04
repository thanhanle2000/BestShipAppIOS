part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class RefreshHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class PublishHomeEvent extends HomeEvent {
  final String body;
  final File image;

  const PublishHomeEvent({required this.body, required this.image})
      : assert(body != null);

  @override
  List<Object> get props => [];
}

class UpdateReplyCountEvent extends HomeEvent {
  final int tweetID;
  final int count;

  const UpdateReplyCountEvent({required this.tweetID, required this.count});

  @override
  List<Object> get props => [];
}

class DeleteHomeEvent extends HomeEvent {
  final int tweetID;

  const DeleteHomeEvent({required this.tweetID});

  @override
  List<Object> get props => [];
}
