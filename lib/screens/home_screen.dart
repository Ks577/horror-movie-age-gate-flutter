import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:movie_age_gate/const/colors/text_color.dart';
import '../widgets/age_input_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ageController = TextEditingController();
  final FlipCardController _flipController = FlipCardController();

  String _dynamicHint = "";
  String _message = "";

  void ageOnChanged(String value) {
    setState(() {
      int? age = int.tryParse(value);
      if (age != null) {
        if (age < 13) {
          _dynamicHint = "Hmm...";
        } else if (age <= 15) {
          _dynamicHint = "Are you sure?";
        } else if (age <= 17) {
          _dynamicHint = "Careful, scary stuff ahead";
        } else {
          _dynamicHint = "You are brave enough!";
        }
      } else {
        _dynamicHint = '';
      }
    });
  }

  void ageCriteria() {
    setState(() {
      int? age = int.tryParse(_ageController.text);
      if (age == null) {
        _message = "Please enter a valid age";
      } else if (age < 16) {
        _message = "You are too young to see such things.";
      } else if (age <= 17) {
        _message = "You can come with adults.";
      } else {
        _message = "You can see this movie.";
      }
    });
  }

  void clearText() => _ageController.clear();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Horror Movie',
                  style: TextStyle(
                    fontFamily: 'Caprasimo',
                    color: baseTextColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Inferna',
                  style: TextStyle(
                    fontFamily: 'Caprasimo',
                    color: Colors.deepOrange[700],
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        color: Colors.black,
                        blurRadius: 3,
                      ),
                    ],
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlipCard(
                        controller: _flipController,
                        rotateSide: RotateSide.bottom,
                        frontWidget: AgeInputCard(
                          controller: _ageController,
                          hintMessage: _dynamicHint,
                          onChanged: ageOnChanged,
                          isFront: true,
                        ),
                        backWidget: AgeInputCard(
                          controller: _ageController,
                          hintMessage: _dynamicHint,
                          resultMessage: _message,
                          onChanged: ageOnChanged,
                          isFront: false,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          ageCriteria();
                          clearText();
                          _dynamicHint = '';
                          _flipController.flipcard();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black26,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
