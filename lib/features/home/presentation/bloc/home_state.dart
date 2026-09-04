part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeInLoadInProgress extends HomeState {}

final class HomeLoadFailure extends HomeState {
  final String message;

  HomeLoadFailure({required this.message});
}

final class HomeLoadSuccess extends HomeState {
  final List<HomeBanner> banners;
  final List<ProductCategory> categories;

  HomeLoadSuccess({required this.banners, required this.categories});
}
