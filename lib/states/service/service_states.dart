import 'package:equatable/equatable.dart';

import 'service_repository.dart';

sealed class ServiceState extends Equatable {}

class ServiceInitial extends ServiceState {
  @override
  List<Object?> get props => [];
}

class ServiceLoading extends ServiceState {
  @override
  List<Object?> get props => [];
}

class ServiceSuccess extends ServiceState {
  ServiceSuccess({required this.services});
  final List<ServiceModel> services;
  @override
  List<Object?> get props => [services];
}

class ServiceFailure extends ServiceState {
  ServiceFailure({required this.error});
  final String error;
  @override
  List<Object?> get props => [];
}
