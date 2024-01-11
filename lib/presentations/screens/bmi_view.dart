import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
final _formKey = GlobalKey<FormState>();

class BMIView extends ConsumerWidget {
  const BMIView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Body Mass Index BMI'),
          actions: [
            IconButton(
                onPressed: () {
                  _resetBMI(ref: ref);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Center(child: Consumer(
          builder: (context, ref, child) {
            final bmi = ref.watch(bmiProvider);
            final evaluete = bmi == 0.0
                ? null
                : evalueteList
                    .where((e) => bmi < e.end && bmi >= e.start)
                    .single;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Không được để trống';
                                }
                                if (value == '0.0') {
                                  return 'Nhập lớn hơn 0';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Nhập cân nặng (kg)',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: const BorderSide(
                                          color: Colors.amber)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32))),
                              controller: _weightController,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Không được để trống';
                                }
                                if (value == '0.0') {
                                  return 'Nhập lớn hơn 0';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Nhập chiều cao (cm)',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: const BorderSide(
                                          color: Colors.amber)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32))),
                              controller: _heightController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                          // style: ButtonStyle(
                          //     shape: MaterialStateProperty.all(
                          //         RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(16))),
                          //     elevation: MaterialStateProperty.all(10),
                          //     maximumSize:
                          //         MaterialStateProperty.all(const Size(200, 60)),
                          //     minimumSize:
                          //         MaterialStateProperty.all(const Size(200, 60)),
                          //     backgroundColor:
                          //         MaterialStateProperty.all(Colors.amber)),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              ref.read(bmiProvider.notifier).update((state) =>
                                  double.parse(_weightController.text) /
                                  ((double.parse(_heightController.text) /
                                          100) *
                                      (double.parse(_heightController.text) /
                                          100)));
                            }
                          },
                          child: Text(
                            'Xem chỉ số BMI'.toUpperCase(),
                            style: const TextStyle(fontSize: 16),
                          )),
                    ),
                    Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.amber, width: 2)),
                            child: Text(
                                    bmi != 0.0
                                        ? '$bmi'.substring(0, 4)
                                        : '$bmi',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))
                                .animate(target: bmi != 0.0 ? 1 : 0)
                                .slide(duration: const Duration(seconds: 2)))
                        .animate(
                          target: bmi != 0 ? 1 : 0,
                        )
                        .scaleXY(),
                    _buildCard(
                        text: 'Chỉ số BMI cho thấy ${evaluete?.name}',
                        duration: 2,
                        bmi: bmi,
                        isScaleX: true),
                    _buildCard(
                        text: 'Cân nặng lý tưởng ${_idealWeight(
                          height: _heightController.text != ''
                              ? double.parse(_heightController.text)
                              : 0,
                        ).toString()}',
                        bmi: bmi,
                        duration: 3,
                        isScaleX: false),
                    _buildCard(
                        text:
                            'Cân nặng tối thiểu ${_minimumWeight(height: _heightController.text != '' ? double.parse(_heightController.text) : 0).toString()}',
                        bmi: bmi,
                        duration: 2,
                        isScaleX: true),
                    _buildCard(
                        text:
                            'Cân nặng tối đa ${_maximumWeight(height: _heightController.text != '' ? double.parse(_heightController.text) : 0).toString()}',
                        bmi: bmi,
                        duration: 2,
                        isScaleX: false),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}

Widget _buildCard(
    {required String text,
    required int duration,
    required double bmi,
    required bool isScaleX}) {
  return isScaleX
      ? Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48)),
              // color: const Color(0xff676765),
              child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  title: Text(
                    text,
                    textAlign: TextAlign.center,
                  )))
          .animate(
            target: bmi != 0 ? 1 : 0,
          )
          .scaleX()
      : Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48)),
              // color: const Color(0xff676765),
              child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  title: Text(
                    text,
                    textAlign: TextAlign.center,
                  )))
          .animate(
            target: bmi != 0 ? 1 : 0,
          )
          .scaleY();
}

double _idealWeight({required double height}) {
  ///(số lẻ chiều cao * 9)/10
  return ((height - 100) * 9) / 10;
}

double _minimumWeight({required double height}) {
  return ((height - 100) * 8) / 10;
}

double _maximumWeight({required double height}) {
  return height - 100;
}

void _resetBMI({required WidgetRef ref}) {
  _weightController.clear();
  _heightController.clear();
  ref.read(bmiProvider.notifier).update((state) => 0.0);
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
