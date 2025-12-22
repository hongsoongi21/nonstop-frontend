import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  final VoidCallback? onRetry;

  const AppErrorWidget({super.key, required this.errorDetails, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                _getErrorMessage(errorDetails),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (onRetry != null)
                ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }

  String _getErrorMessage(FlutterErrorDetails details) {
    if (details.exception is PlatformException) {
      final platformException = details.exception as PlatformException;
      return platformException.message ?? 'Platform error occurred';
    }

    return details.exception.toString();
  }
}
