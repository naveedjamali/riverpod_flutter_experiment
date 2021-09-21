import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/number_state_notifier.dart';

void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

final numberProvider = Provider<int>((ref) => 42);
final numberStateProvider = StateProvider((ref) => 42);
final numbersNotifierProvider =
    StateNotifierProvider<NumbersNotifier, List<int>>((ref) {
  return NumbersNotifier();
});

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final number = watch(numberProvider);
    final numberState = watch(numberStateProvider).state;
    final numbersNotifierState = watch(numbersNotifierProvider);

    return Scaffold(
        body: Center(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Text(numbersNotifierState[index].toString());
          },
          itemCount: numbersNotifierState.length,
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read(numbersNotifierProvider).add(5),
          child: const Icon(Icons.plus_one),
        ));
  }
}
