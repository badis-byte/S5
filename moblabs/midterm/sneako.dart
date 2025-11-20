import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SnakeGameApp extends StatelessWidget {
  const SnakeGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SnakeGameScreen(),
    );
  }
}

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({Key? key}) : super(key: key);

  @override
  _SnakeGameScreenState createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int gridSize = 20;
  List<int> snake = [45, 44, 43];
  int food = 55;
  String direction = 'right';
  bool isPlaying = false;
  bool gameOver = false;
  int score = 0;
  Timer? gameTimer;

  void startGame() {
    setState(() {
      snake = [45, 44, 43];
      direction = 'right';
      isPlaying = true;
      gameOver = false;
      score = 0;
      generateFood();
    });

    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateSnake();
    });
  }

  void generateFood() {
    Random random = Random();
    food = random.nextInt(gridSize * gridSize);
    while (snake.contains(food)) {
      food = random.nextInt(gridSize * gridSize);
    }
  }

  void updateSnake() {
    if (!isPlaying || gameOver) return;

    setState(() {
      int head = snake.first;
      int newHead = head;

      switch (direction) {
        case 'up':
          newHead = head - gridSize;
          break;
        case 'down':
          newHead = head + gridSize;
          break;
        case 'left':
          newHead = head - 1;
          break;
        case 'right':
          newHead = head + 1;
          break;
      }

      // Check wall collision
      if (newHead < 0 || newHead >= gridSize * gridSize ||
          (direction == 'left' && head % gridSize == 0) ||
          (direction == 'right' && head % gridSize == gridSize - 1)) {
        endGame();
        return;
      }

      // Check self collision
      if (snake.contains(newHead)) {
        endGame();
        return;
      }

      snake.insert(0, newHead);

      // Check if food eaten
      if (newHead == food) {
        score += 10;
        generateFood();
      } else {
        snake.removeLast();
      }
    });
  }

  void endGame() {
    setState(() {
      gameOver = true;
      isPlaying = false;
    });
    gameTimer?.cancel();
  }

  void changeDirection(String newDirection) {
    if ((direction == 'up' && newDirection != 'down') ||
        (direction == 'down' && newDirection != 'up') ||
        (direction == 'left' && newDirection != 'right') ||
        (direction == 'right' && newDirection != 'left')) {
      setState(() {
        direction = newDirection;
      });
    }
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Snake Game'),
        backgroundColor: Colors.green,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Score: $score',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[900],
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gridSize * gridSize,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                ),
                itemBuilder: (context, index) {
                  bool isSnake = snake.contains(index);
                  bool isHead = index == snake.first;
                  bool isFood = index == food;

                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: isSnake
                          ? (isHead ? Colors.green.shade700 : Colors.green)
                          : (isFood ? Colors.red : Colors.grey[800]),
                      borderRadius: BorderRadius.circular(isFood ? 10 : 3),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey[850],
            child: Column(
              children: [
                if (gameOver)
                  Column(
                    children: [
                      const Text(
                        '🎮 Game Over!',
                        style: TextStyle(fontSize: 28, color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Final Score: $score',
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ElevatedButton(
                  onPressed: startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    isPlaying ? 'Restart' : 'Start Game',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => changeDirection('up'),
                          icon: const Icon(Icons.arrow_upward, size: 40, color: Colors.white),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => changeDirection('left'),
                              icon: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
                            ),
                            const SizedBox(width: 50),
                            IconButton(
                              onPressed: () => changeDirection('right'),
                              icon: const Icon(Icons.arrow_forward, size: 40, color: Colors.white),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => changeDirection('down'),
                          icon: const Icon(Icons.arrow_downward, size: 40, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

