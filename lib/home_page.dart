import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/my_bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double score = 0;
  double height = 0;
  double bestScore = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  bool checkLose() {
    if (barrierXone < 0.4 && barrierXone > -0.4) {
      if (birdYaxis < -0.3 || birdYaxis > .4) {
        return true;
      }
    }
    if (barrierXtwo < 0.3 && barrierXtwo > -0.3) {
      if (birdYaxis < -0.1 || birdYaxis > 0.6) {
        return true;
      }
    }
    return false;
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        score += .1 / 3;
        if (barrierXone < -1.4) {
          barrierXone += 3;
        } else {
          barrierXone -= .05;
        }
      });
      setState(() {
        if (barrierXtwo < -1.4) {
          barrierXtwo += 3;
        } else {
          barrierXtwo -= .05;
        }
      });

      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      if (birdYaxis > 1.1 || birdYaxis < -1.05 || checkLose()) {
        timer.cancel();

        setState(() {
          if (score > bestScore) {
            bestScore = score;
          }
          score = 0;

          time = 0;
          height = 0;
          initialHeight = 0;
          birdYaxis = 0;
          gameHasStarted = false;

          barrierXone = 1;
          barrierXtwo = 2.5;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else
          startGame();
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      color: Colors.blue,
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      child: MyBird(),
                    ),
                    Container(
                        alignment: Alignment(0, -.3),
                        child: gameHasStarted
                            ? Text('')
                            : const Text(
                                'T A P  TO  P L A Y',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(barrierXone, 1.1),
                      child: MyBarrier(
                        size: 187.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(barrierXone, -1.1),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(barrierXtwo, 1.1),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXtwo, -1.1),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'SCORE',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('${score.toInt()}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('BEST',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          SizedBox(
                            height: 20,
                          ),
                          Text('${bestScore.toInt()}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
