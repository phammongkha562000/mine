// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
final _weightController = TextEditingController();
final _heightController = TextEditingController();
//   BMI <16: Gầy độ III
// 16 ≤ BMI <17: Gầy độ II
// 17 ≤ BMI <18.5: Gầy độ I
// 18.5 ≤ BMI <25: Bình thường
// 25 ≤ BMI <30: Thừa cân
// 30 ≤ BMI 35: Béo phì độ 1
// 35 ≤ BMI <40: Béo phì độ II
// BMI >40: Béo phì độ III
List<EvaluateBMI> evalueteList = [
  EvaluateBMI(id: 1, name: 'Cân nặng gầy', start: 0.0, end: 18.5),
  EvaluateBMI(id: 2, name: 'Bình thuờng', start: 18.5, end: 25),
  EvaluateBMI(id: 3, name: 'Thừa cân', start: 25, end: 30),
  EvaluateBMI(id: 4, name: 'Béo phì độ I', start: 30, end: 35),
  EvaluateBMI(id: 5, name: 'Béo phì độ II', start: 35, end: 40),
  EvaluateBMI(id: 6, name: 'Béo phì độ III', start: 40, end: 1000),
];

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo')),
      body: Center(child: Consumer(
        builder: (context, ref, child) {
          final bmi = ref.watch(bmiProvider);
          final id = bmi == 0.0
              ? null
              : evalueteList
                  .where((e) => bmi < e.end && bmi >= e.start)
                  .single
                  .id;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                  controller: _weightController,
                ),
                SizedBox(height: 8,),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                  controller: _heightController,
                ),
                Text('$bmi')
                    .animate(target: bmi != 0.0 ? 1 : 0)
                    .slideY(duration: Duration(seconds: 5)),
                // OpenContainer(
                //   openColor: Colors.pink,
                //   transitionDuration: Duration(seconds: 1),
                //   transitionType: ContainerTransitionType.fadeThrough,
                //   closedBuilder: (context, action) => Text('Small widget'),
                //   openBuilder: (context, action) => BigWiget(
                //     id: 2,
                //   ),
                // ),
                Expanded(
                    child: ListView.builder(
                  itemCount: evalueteList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: evalueteList[index].id == id ? Colors.amber : null,
                      child: ListTile(title: Text(evalueteList[index].name))
                          .animate(target: evalueteList[index].id == id ? 1 : 0)
                          .scaleX(),
                    );
                  },
                ))
              ],
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () => ref.read(bmiProvider.notifier).update((state) =>
            double.parse(_weightController.text) /
            (double.parse(_heightController.text) * 2)),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EvaluateBMI {
  final int id;
  final String name;
  final double start;
  final double end;
  EvaluateBMI({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
  });
}

class BigWiget extends StatefulWidget {
  const BigWiget({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;
  @override
  State<BigWiget> createState() => _BigWigetState();
}

class _BigWigetState extends State<BigWiget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id.toString())),
    );
  }
}
