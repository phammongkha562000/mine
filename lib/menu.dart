import 'package:bmi_pj/constants/route_paths.dart' as route;
import 'package:bmi_pj/data/services/injection/injection.dart';
import 'package:bmi_pj/data/services/navigator/navigation_service.dart';
import 'package:bmi_pj/presentations/screens/bmi_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class MenuView extends StatefulWidget {
  MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final _navigationService = getIt<NavigationService>();

  void _onIntroEnd(context) {
    _navigationService.pushNamed(route.bmiRoute);
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/icons/todo_list.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Image.asset('assets/icons/$assetName', width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 10000,
        infiniteAutoScroll: true,
        // globalHeader: Align(
        //   alignment: Alignment.topRight,
        //   child: SafeArea(
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 16, right: 16),
        //       child: _buildImage('todo_list.png', 100),
        //     ),
        //   ),
        // ),
        // globalFooter: SizedBox(
        //   width: double.infinity,
        //   height: 60,
        //   child: ElevatedButton(
        //     child: const Text(
        //       'Let\'s go right away!',
        //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        //     ),
        //     onPressed: () => _onIntroEnd(context),
        //   ),
        // ),
        pages: [
          // PageViewModel(
          //   title: "Fractional shares",
          //   body:
          //       "Instead of having to buy an entire share, invest any amount you want.",
          //   image: _buildImage('todo_list.png'),
          //   decoration: pageDecoration,
          // ),
          // PageViewModel(
          //   title: "Learn as you go",
          //   body:
          //       "Download the Stockpile app and master the market with our mini-lesson.",
          //   image: _buildImage('todo_list.png'),
          //   decoration: pageDecoration,
          // ),
          // PageViewModel(
          //   title: "Kids and teens",
          //   body:
          //       "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          //   image: _buildImage('todo_list.png'),
          //   decoration: pageDecoration,
          // ),
          PageViewModel(
              title: 'BMI',
              body: 'What BMI is overweight or obese?',
              image: _buildImage('bmi.png'),
              decoration: pageDecoration.copyWith(
                bodyFlex: 2,
                imageFlex: 4,
                bodyAlignment: Alignment.bottomCenter,
                imageAlignment: Alignment.center,
              ),
              footer: ElevatedButton(
                  onPressed: () {
                    _navigationService.pushNamed(route.bmiRoute);
                  },
                  child: const Text('See your BMI'))),
          PageViewModel(
              title: "Todo",
              body: "Things you must do",
              image: _buildImage('todo_list.png'),
              reverse: true,
              decoration: pageDecoration.copyWith(
                bodyFlex: 2,
                imageFlex: 4,
                bodyAlignment: Alignment.bottomCenter,
                imageAlignment: Alignment.center,
              ),
              footer: ElevatedButton(
                  onPressed: () {
                    _navigationService.pushNamed(route.todoListRoute);
                  },
                  child: const Text('See your Todo list'))),
          PageViewModel(
            title: "Task History",
            bodyWidget: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Click on ", style: bodyStyle),
                Icon(Icons.edit),
                Text(" to edit a task", style: bodyStyle),
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.center,
            ),
            image: _buildImage('soon.png'),
            reverse: true,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
