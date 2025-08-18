import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../services/api_service.dart';

class AppProvider with ChangeNotifier {
  List<Map<String, dynamic>> _apiPosts = [];
  bool _isLoading = false;
  String? _error;
  bool _isWakelockEnabled = false;

  List<Map<String, dynamic>> get apiPosts => _apiPosts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isWakelockEnabled => _isWakelockEnabled;

  Future<void> loadApiPosts() async {
    _setLoading(true);
    try {
      _apiPosts = await ApiService.getPosts();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleWakelock() async {
    try {
      if (_isWakelockEnabled) {
        await WakelockPlus.disable();
      } else {
        await WakelockPlus.enable();
      }
      _isWakelockEnabled = !_isWakelockEnabled;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }
}
