import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SnakeGameApp extends StatelessWidget {
  const SnakeGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnakeGameScreen(),
    );
  }
}

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({Key? key}) : super(key: key);

  @override
  _SnakeGameScreenState createState() => _SnakeGameScreenState();
}

enum SegmentColor { green, red, yellow }

class SnakeSegment {
  int position;
  SegmentColor color;
  SnakeSegment(this.position, this.color);
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int rowSize = 26;
  static const int colSize = 22;

  int get centerRow => rowSize ~/ 2;
  int get centerCol => colSize ~/ 2;
  int get centerPosition => centerRow * colSize + centerCol;

  List<SnakeSegment> snake = [];
  int? healthyFood;
  Set<int> unhealthyFoods = {};
  List<int> obstacles = [];
  String direction = 'right';
  bool isPlaying = false;
  bool gameOver = false;
  int score = 0;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    snake = [
      SnakeSegment(centerPosition, SegmentColor.green),
      SnakeSegment(centerPosition - 1, SegmentColor.green),
      SnakeSegment(centerPosition - 2, SegmentColor.green),
    ];
    generateFoods(initial: true);
    generateInitialObstacles();
  }

  void startGame() {
    setState(() {
      snake = [
        SnakeSegment(centerPosition, SegmentColor.green),
        SnakeSegment(centerPosition - 1, SegmentColor.green),
        SnakeSegment(centerPosition - 2, SegmentColor.green),
      ];
      obstacles.clear();
      direction = 'right';
      isPlaying = true;
      gameOver = false;
      score = 0;
      unhealthyFoods.clear();
      generateFoods(initial: true);
      generateInitialObstacles();
    });

    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateSnake();
    });
  }

  void generateFoods({bool initial = false}) {
    Random random = Random();
    Set<int> occupiedCells = {
      ...snake.map((s) => s.position),
      ...obstacles,
    };

    // Generate one healthy food
    do {
      healthyFood = random.nextInt(rowSize * colSize);
    } while (occupiedCells.contains(healthyFood));
    occupiedCells.add(healthyFood!);

    // Generate multiple unhealthy foods
    if (initial) {
      unhealthyFoods.clear();
      for (int i = 0; i < 20; i++) {
        int pos;
        do {
          pos = random.nextInt(rowSize * colSize);
        } while (occupiedCells.contains(pos));
        unhealthyFoods.add(pos);
        occupiedCells.add(pos);
      }
    } else {
      while (unhealthyFoods.length < 20) {
        int pos;
        do {
          pos = random.nextInt(rowSize * colSize);
        } while (occupiedCells.contains(pos));
        unhealthyFoods.add(pos);
      }
    }
  }

  void generateInitialObstacles() {
    Random random = Random();
    Set<int> occupiedCells = {
      ...snake.map((s) => s.position),
      ...unhealthyFoods,
      if (healthyFood != null) healthyFood!,
    };
    obstacles.clear();
    for (int i = 0; i < 5; i++) {
      int pos;
      do {
        pos = random.nextInt(rowSize * colSize);
      } while (occupiedCells.contains(pos));
      obstacles.add(pos);
      occupiedCells.add(pos);
    }
  }

  void generateObstacle() {
    Random random = Random();
    Set<int> occupiedCells = {
      ...snake.map((s) => s.position),
      ...obstacles,
      ...unhealthyFoods,
      if (healthyFood != null) healthyFood!,
    };
    int newObstacle;
    do {
      newObstacle = random.nextInt(rowSize * colSize);
    } while (occupiedCells.contains(newObstacle));
    obstacles.add(newObstacle);
  }

SegmentColor move(List<SnakeSegment> snake){
  SegmentColor color = snake[0].color;
  for(var i=0; i<snake.length-1 ; i++){
    snake[i].color = snake[i+1].color;
  }
  return color;
}

void updateSnake() {
  if (!isPlaying || gameOver) return;

  setState(() {
    int head = snake.first.position;
    int newHead = head;
    int currentRow = head ~/ colSize;
    int currentCol = head % colSize;

    // Determine new head position
    switch (direction) {
      case 'up':
        newHead = head - colSize;
        break;
      case 'down':
        newHead = head + colSize;
        break;
      case 'left':
        newHead = head - 1;
        break;
      case 'right':
        newHead = head + 1;
        break;
    }

    int newRow = newHead ~/ colSize;
    int newCol = newHead % colSize;

    // Check wall collision
    if (newHead < 0 ||
        newHead >= rowSize * colSize ||
        newRow < 0 ||
        newRow >= rowSize ||
        (direction == 'left' && currentCol == 0) ||
        (direction == 'right' && currentCol == colSize - 1)) {
      endGame();
      return;
    }

    // Check self collision
    if (snake.any((segment) => segment.position == newHead)) {
      endGame();
      return;
    }

    // Check obstacle collision
    if (obstacles.contains(newHead)) {
      handleObstacleCollision();
      return;
    }

    bool ateFood = false;

    // Eating healthy food
    if (newHead == healthyFood) {
      snake.insert(0, SnakeSegment(newHead, snake.first.color)); // head keeps color
      score += 2; // +2 points
      // Tail keeps food color
      snake[snake.length - 1].color = SegmentColor.green;
      ateFood = true;
      generateFoods();
    }
    // Eating unhealthy food
    else if (unhealthyFoods.contains(newHead)) {
      unhealthyFoods.remove(newHead);
      snake.insert(0, SnakeSegment(newHead, SegmentColor.red)); // head keeps color
      score -= 1; // -1 point
      // Tail keeps food color

      generateObstacle(); // Add obstacle

      // Add 2 new red foods
      Random random = Random();
      Set<int> occupiedCells = {
        ...snake.map((s) => s.position),
        ...obstacles,
        ...unhealthyFoods,
        if (healthyFood != null) healthyFood!,
      };
      for (int i = 0; i < 2; i++) {
        int pos;
        do {
          pos = random.nextInt(rowSize * colSize);
        } while (occupiedCells.contains(pos));
        unhealthyFoods.add(pos);
        occupiedCells.add(pos);
      }
    }

    // Normal movement if no food eaten
    if (!ateFood) {
      var color = move(snake);
      snake.insert(0, SnakeSegment(newHead, color));
      snake.removeLast();// Only remove last if no food eaten, tail color remains
    }
  });
}




void handleObstacleCollision() {
  setState(() {
    Random random = Random();

    // Find all yellow segments
    List<int> yellowIndices = [];
    for (int i = 0; i < snake.length; i++) {
      if (snake[i].color == SegmentColor.yellow) {
        yellowIndices.add(i);
      }
    }

    if (yellowIndices.isNotEmpty) {
      // Turn a random yellow segment into red
      int randomIndex = yellowIndices[random.nextInt(yellowIndices.length)];
      snake[randomIndex].color = SegmentColor.red;
    } else {
      // No yellow segments, turn a green one into yellow
      List<int> greenIndices = [];
      for (int i = 0; i < snake.length; i++) {
        if (snake[i].color == SegmentColor.green) {
          greenIndices.add(i);
        }
      }
      if (greenIndices.isNotEmpty) {
        int randomIndex = greenIndices[random.nextInt(greenIndices.length)];
        snake[randomIndex].color = SegmentColor.yellow;
      }
    }

    // Check if all segments are yellow (game over condition)
    bool allYellow = snake.every((segment) => segment.color == SegmentColor.yellow);
    if (allYellow) {
      endGame();
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

  Color getSegmentColor(SegmentColor segmentColor, bool isHead) {
    switch (segmentColor) {
      case SegmentColor.green:
        return isHead ? Colors.green.shade700 : Colors.green;
      case SegmentColor.red:
        return isHead ? Colors.red.shade700 : Colors.red;
      case SegmentColor.yellow:
        return isHead ? Colors.yellow.shade700 : Colors.yellow;
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
              child: AspectRatio(
                aspectRatio: colSize / rowSize,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rowSize * colSize,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: colSize,
                  ),
                  itemBuilder: (context, index) {
                    SnakeSegment? segment = snake.firstWhere(
                      (s) => s.position == index,
                      orElse: () => SnakeSegment(-1, SegmentColor.green),
                    );
                    bool isSnake = segment.position == index;
                    bool isHead = isSnake && index == snake.first.position;
                    bool isHealthyFood = index == healthyFood;
                    bool isUnhealthyFood = unhealthyFoods.contains(index);
                    bool isObstacle = obstacles.contains(index);

                    Color cellColor;
                    if (isSnake) {
                      cellColor = getSegmentColor(segment.color, isHead);
                    } else if (isHealthyFood) {
                      cellColor = Colors.green.shade400;
                    } else if (isUnhealthyFood) {
                      cellColor = Colors.red.shade400;
                    } else if (isObstacle) {
                      cellColor = Colors.black;
                    } else {
                      cellColor = Colors.grey[800]!;
                    }

                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: cellColor,
                        borderRadius: BorderRadius.circular(
                            (isHealthyFood || isUnhealthyFood) ? 10 : 3),
                        border: isObstacle
                            ? Border.all(color: Colors.grey.shade600, width: 1)
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey[850],
            child: Column(
              children: [
                if (gameOver)
                  Column(
                    children: [
                      const Text(
                        'Game Over!',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Final Score: $score',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: startGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                      ),
                      child: Text(
                        isPlaying ? 'Restart' : 'Start Game',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Text(' +2 ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Text(' -1 ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const Text(' DANGER',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => changeDirection('up'),
                          icon: const Icon(Icons.arrow_upward,
                              size: 30, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => changeDirection('left'),
                              icon: const Icon(Icons.arrow_back,
                                  size: 30, color: Colors.white),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 40),
                            IconButton(
                              onPressed: () => changeDirection('right'),
                              icon: const Icon(Icons.arrow_forward,
                                  size: 30, color: Colors.white),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => changeDirection('down'),
                          icon: const Icon(Icons.arrow_downward,
                              size: 30, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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
