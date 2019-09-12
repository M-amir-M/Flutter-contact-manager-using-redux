class AppState {
  final bool isLoading;
  final Map contacts;
  final Map filtered;
  final List favorites;
  AppState({this.isLoading = false, this.contacts = const {},this.filtered = const {},this.favorites = const []});

  AppState copyWith({bool isLoading, Map contacts, Map filtered, List favorites}) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      contacts: contacts ?? this.contacts,
      filtered: filtered ?? this.filtered,
      favorites: favorites ?? this.favorites,
    );
  }

  factory AppState.loading() => new AppState(isLoading: false);

  factory AppState.initialState() => AppState(
        isLoading: false,
        favorites: [],
        contacts: {
          "data": [],
          "page": 1,
          "total_row": 10,
        },
        filtered: {
          "data": [],
          "page": 1,
          "total_row": 10,
        },
      );
}
