part of '../api.dart';

@Riverpod(dependencies: <Object>[api])
class Home extends _$Home {
  @override
  Future<HomeResponse> build() {
    final API api = ref.read(apiProvider);
    return api.getHome();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<HomeResponse>();
    state = await AsyncValue.guard(() {
      final API api = ref.read(apiProvider);
      return api.getHome();
    });
  }
}
