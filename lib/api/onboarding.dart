part of 'api.dart';

mixin $Onboarding {
  @GET('/onboarding/genres')
  Future<List<Genre>> getOnboardingGenres();

  @POST('/onboarding/preferences')
  Future<void> savePreferences(@Body() SavePreferencesRequest request);
}

@MappableClass()
class SavePreferencesRequest with SavePreferencesRequestMappable {
  const SavePreferencesRequest({required this.genreIds});

  @MappableField(key: 'genre_ids')
  final List<int> genreIds;
}
