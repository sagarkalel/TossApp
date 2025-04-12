import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHead = true;
  bool isLoading = false;
  bool restartLoading = false;
  int headCount = 0;
  int tailCount = 0;

  Future<void> _flipToss() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(milliseconds: 1500));
    final val = Random().nextBool();
    isHead = val;
    if (isHead) {
      headCount++;
    } else {
      tailCount++;
    }
    setState(() => isLoading = false);
  }

  Future<void> _restart() async {
    setState(() => restartLoading = true);
    await Future.delayed(Duration(milliseconds: 1500));
    headCount = tailCount = 0;
    setState(() => restartLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("True Toss", style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.purple.shade100,
        elevation: 8,
        actions: [
          if (tailCount != 0 || headCount != 0)
            TextButton.icon(
              onPressed: _restart,
              icon: Icon(Icons.restart_alt),
              label: Text("Restart"),
            )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "HEADS",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      AnimatedFlipCounter(
                        value: headCount,
                        textStyle: TextStyle(
                            color: Colors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "TAILS",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      AnimatedFlipCounter(
                        value: tailCount,
                        textStyle: TextStyle(
                            color: Colors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: w * .8,
              width: w * .8,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(100),
                borderRadius: BorderRadius.circular(20),
              ),
              child: isLoading
                  ? Lottie.asset("assets/flip_coin_lottie.json", repeat: false)
                  : restartLoading
                      ? Lottie.asset("assets/restart.json", repeat: false)
                      : headCount == 0 && tailCount == 0
                          ? Text("Flip Your Coin")
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    isHead
                                        ? "assets/head.jpeg"
                                        : "assets/tail.jpg",
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  isHead ? "HEAD" : "TAILS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _flipToss,
              label: Text("Flip Coin"),
            )
          ],
        ),
      ),
    );
  }
}
