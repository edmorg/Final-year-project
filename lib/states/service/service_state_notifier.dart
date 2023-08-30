import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_hunter/states/service/service_repository.dart';
import 'package:skill_hunter/states/service/service_states.dart';

class ServiceStateNotifier extends StateNotifier<ServiceState> {
  ServiceStateNotifier() : super(ServiceInitial());
  final ServiceRepository _repository = ServiceRepository();
  Future<void> getServices() async {
    try {
      state = ServiceLoading();
      final response = await _repository.getServices();
      if (response.status) {
        state = ServiceSuccess(services: response.data!);
      } else {
        state = ServiceFailure(
          error: response.message ?? "Couldn't fetch  Services",
        );
      }
    } catch (err) {
      state = ServiceFailure(error: err.toString());
    }
  }
}

class SearchServiceStateNotifier extends StateNotifier<ServiceState> {
  SearchServiceStateNotifier() : super(ServiceInitial());
  final ServiceRepository _repository = ServiceRepository();
  Future<void> getServices({required String queryParam}) async {
    try {
      state = ServiceLoading();
      final response = await _repository.searchService(queryParam: queryParam);
      if (response.status) {
        state = ServiceSuccess(services: response.data!);
      } else {
        state = ServiceFailure(
          error: response.message ?? "Couldn't find Services",
        );
      }
    } catch (err) {
      state = ServiceFailure(error: err.toString());
    }
  }
}

final searchStateProvider = StateNotifierProvider.autoDispose<SearchServiceStateNotifier, ServiceState>((ref) {
  return SearchServiceStateNotifier();
});
final serviceStateProvider = StateNotifierProvider<ServiceStateNotifier, ServiceState>((ref) {
  return ServiceStateNotifier();
});
