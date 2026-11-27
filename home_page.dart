import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final PageController pageController;

  const HomePage({
    super.key,
    required this.pageController,
  });

  // value постепенно меняется от 0 до 1.
  Widget animatedText(String text, int milliseconds) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: milliseconds),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF101C18),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          animatedText('Experience', 700),
          animatedText('The', 1000),
          animatedText('Romantic', 1300),
          animatedText('Culture', 1600),
          SizedBox(height: 200),
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white)
              ),
              onPressed: () {
                pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
              child: Text('Scroll to see more', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white))
            ),
          ),
        ],
      ),
    );
  }
}
