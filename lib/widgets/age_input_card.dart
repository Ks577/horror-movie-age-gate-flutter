import 'package:flutter/material.dart';
import 'package:movie_age_gate/const/colors/text_color.dart';

class AgeInputCard extends StatefulWidget {
  final TextEditingController controller;
  final String hintMessage;
  final String? resultMessage;
  final Function(String) onChanged;
  final bool isFront;

  const AgeInputCard({
    super.key,
    required this.controller,
    required this.hintMessage,
    this.resultMessage,
    required this.onChanged,
    required this.isFront,
  });

  @override
  State<AgeInputCard> createState() => _AgeInputCardState();
}

class _AgeInputCardState extends State<AgeInputCard> {
  double offsetX = 0;

  @override
  void didUpdateWidget(covariant AgeInputCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isFront && widget.hintMessage == "Hmm...") {
      shakeCard();
    } else {
      offsetX = 0;
    }
  }

  void shakeCard() async {
    const duration = Duration(milliseconds: 50);
    for (int i = 0; i < 6; i++) {
      setState(() {
        offsetX = (i % 2 == 0 ? 5.0 : -5.0);
      });
      await Future.delayed(duration);
    }
    setState(() {
      offsetX = 0;
    });
  }

  Color getHintColor(String hint) {
    switch (hint) {
      case "Hmm...":
        return Colors.red.shade400;
      case "Are you sure?":
        return Colors.orange.shade400;
      case "Careful, scary stuff ahead":
        return Colors.yellow.shade400;
      case "You are brave enough!":
        return Colors.green.shade400;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      transform: Matrix4.translationValues(offsetX, 0, 0),
      child: Card(
        elevation: 5,
        color: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: 250,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: widget.isFront
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: widget.controller,
                        onChanged: widget.onChanged,
                        cursorColor: Colors.red,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter your age",
                          hintStyle: TextStyle(color: baseTextColor),
                          border: InputBorder.none,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: Text(
                          widget.hintMessage,
                          key: ValueKey<String>(widget.hintMessage),
                          style: TextStyle(
                            color: getHintColor(widget.hintMessage),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      widget.resultMessage ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: baseTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
