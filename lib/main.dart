import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum RadioState {
  disconnected,
  connected,
  loading,
}

class RadioModel {
  RadioState radioState = RadioState.disconnected;
}

class RadioNotifier extends StateNotifier<RadioModel> {
  RadioNotifier() : super(RadioModel());

  void connect() {
    print("connect()");
    state = RadioModel()..radioState = RadioState.connected;
  }

  void disconnect() {
    print("disconnect()");
    state = RadioModel()..radioState = RadioState.disconnected;
  }
}

final userProvider = StateNotifierProvider<RadioNotifier, RadioModel>((ref) {
  return RadioNotifier();
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioModel = ref.watch(userProvider);
    final radioService = ref.read(userProvider.notifier);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Sample')),
        body: Center(
          child: Text("State: ${radioModel.radioState}"),
        ),
        // Add a floating action button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if(radioModel.radioState == RadioState.connected) {
              radioService.disconnect();
            } else {
              radioService.connect();
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
