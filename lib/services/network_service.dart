import 'package:connectivity_plus/connectivity_plus.dart';

/// Service responsible for checking internet connectivity.
/// Important for streaming music and loading data.
class NetworkService {

  final Connectivity _connectivity = Connectivity();

  /// Checks if the device has internet connection
  Future<bool> isConnected() async {

    final result = await _connectivity.checkConnectivity();

    return result != ConnectivityResult.none;
  }

  /// Stream that listens for network changes
  Stream<ConnectivityResult> get connectivityStream {
    return _connectivity.onConnectivityChanged;
  }
}
