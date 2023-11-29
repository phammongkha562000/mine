import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

final bmiProvider = StateProvider((ref) => 0.0);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI')),
      body: Center(child: Consumer(
        builder: (context, ref, child) {
          final bmi = ref.watch(bmiProvider);
          return Column(
            children: [TextFormField(), TextFormField(), Text('$bmi')],
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () => ref.read(bmiProvider.notifier).update((state) => 56/(1.68*2)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
