import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  static const int maxItems = 12;
  final Set<int> _favoriteIndexes = <int>{};

  bool isFavorite(int index) => _favoriteIndexes.contains(index);

  void toggleFavorite(int index) {
    if (_favoriteIndexes.contains(index)) {
      _favoriteIndexes.remove(index);
    } else {
      _favoriteIndexes.add(index);
    }
    notifyListeners();
  }
}
