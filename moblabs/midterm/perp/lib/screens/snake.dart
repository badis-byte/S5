import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController controller;
  Offset? _dragStart;

  @override
  void initState() {
    super.initState();
    controller = GameController(26, 22,
    onUpdate: () => setState(() {}),
    );
    controller.startGame();
  }

  void _onPanStart(DragStartDetails details) =>
      _dragStart = details.globalPosition;

  void _onPanUpdate(DragUpdateDetails details) {
    if (_dragStart == null) return;
    final current = details.globalPosition;
    final delta = current - _dragStart!;
    if (delta.dx.abs() > delta.dy.abs()) {
      if (delta.dx > 0 && controller.direction != Offset(-1, 0)) {
        controller.changeDirection(Offset(1, 0));
      } else if (delta.dx < 0 && controller.direction != Offset(1, 0)) {
        controller.changeDirection(Offset(-1, 0));
      }
    } else {
      if (delta.dy > 0 && controller.direction != Offset(0, -1)) {
        controller.changeDirection(Offset(0, 1));
      } else if (delta.dy < 0 && controller.direction != Offset(0, 1)) {
        controller.changeDirection(Offset(0, -1));
      }
    }
    _dragStart = null;
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Snake Game'),
      actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('Score: ${controller.score}')),
      )],
    ),
    body: Stack(
      children: [
        GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          child: Center(
            child: AspectRatio(
              aspectRatio: 26 / 22,
              child: CustomPaint(
                size: Size.infinite,
                painter: SnakePainter(controller),
              ),
            ),
          ),
        ),
        // Arrow controls overlay
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Up arrow
                IconButton(
                  icon: Icon(Icons.arrow_upward, size: 36),
                  onPressed: () {
                    if (controller.direction != Offset(0, 1)) {
                      controller.changeDirection(Offset(0, -1));
                    }
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Left arrow
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 36),
                      onPressed: () {
                        if (controller.direction != Offset(1, 0)) {
                          controller.changeDirection(Offset(-1, 0));
                        }
                      },
                    ),
                    SizedBox(width: 50), // spacing
                    // Right arrow
                    IconButton(
                      icon: Icon(Icons.arrow_forward, size: 36),
                      onPressed: () {
                        if (controller.direction != Offset(-1, 0)) {
                          controller.changeDirection(Offset(1, 0));
                        }
                      },
                    ),
                  ],
                ),
                // Down arrow
                IconButton(
                  icon: Icon(Icons.arrow_downward, size: 36),
                  onPressed: () {
                    if (controller.direction != Offset(0, -1)) {
                      controller.changeDirection(Offset(0, 1));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => controller.restart(),
      child: Icon(Icons.refresh),
    ),
  );
}
}

class GameController {
  Color lastTailColor = Colors.green;
  final int width;
  final int height;
  final VoidCallback onUpdate;
  List<SnakeSegment> snake = [];
  List<Offset> obstacles = [];
  List<Fruit> fruits = [];
  int score = 0;
  int greenStreak = 0;
  Offset direction = Offset(1, 0);
  Timer? _timer;
  Random random = Random();
  Offset? yellowCell; // Track the yellow cell for second hit

  GameController(this.width, this.height, {required this.onUpdate});

  void startGame() {
    // Initial snake: 3 green cells center
    int centerX = width ~/ 2;
    int centerY = height ~/ 2;
    snake = [
      SnakeSegment(
          Offset(centerX.toDouble(), centerY.toDouble()), Colors.green),
      SnakeSegment(
          Offset((centerX - 1).toDouble(), centerY.toDouble()), Colors.green),
      SnakeSegment(
          Offset((centerX - 2).toDouble(), centerY.toDouble()), Colors.green),
    ];

    // 5 random obstacles
    obstacles = _generateRandomPositions(5,
        exclude: snake.map((s) => s.position).toSet());

    // 20 red fruits
    fruits = [];
    _addRedFruits(20);

    // 1 green fruit
    _addGreenFruit();

    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) => update());
  }

  void restart() {
    _timer?.cancel();
    snake.clear();
    obstacles.clear();
    fruits.clear();
    score = 0;
    greenStreak = 0;
    direction = Offset(1, 0);
    yellowCell = null;
    startGame();
  }

  void changeDirection(Offset newDir) {
    direction = newDir;
  }

  void update() {
    // Move head
    Offset newHead = snake.first.position + direction;
    bool hitWall = newHead.dx < 0 ||
        newHead.dx >= width ||
        newHead.dy < 0 ||
        newHead.dy >= height;
    bool hitSelf = snake.any((s) => s.position == newHead);

    if (hitWall || hitSelf) {
      _gameOver();
      return;
    }

    // Check hit obstacle
    if (obstacles.contains(newHead)) {
      _handleObstacleHit();
    }

    // Add new head
    snake.insert(
        0, SnakeSegment(newHead, lastTailColor)); // New head always green

    // Check fruits
    Fruit? eatenFruit;
    for (Fruit fruit in fruits) {
      if (fruit.position == newHead) {
        eatenFruit = fruit;
        break;
      }
    }
    if (eatenFruit != null) {
  fruits.remove(eatenFruit);
  Offset tailPos = snake.last.position;

  if (eatenFruit.isGreen) {
    lastTailColor = Colors.green;
  } else {
    lastTailColor = Colors.red;
    score -= 1;
    _addRedFruits(2);
    Offset newObs = _getRandomPosition(exclude: _getAllOccupied());
    obstacles.add(newObs);
  }

  // Always add new tail with lastTailColor
  snake.add(SnakeSegment(tailPos, lastTailColor));

  if (eatenFruit.isGreen) {
    score += 2;
    greenStreak++;
    if (greenStreak >= 3) {
      _handleThreeGreens();
      greenStreak = 0;
    }
    _addGreenFruit(); // Respawn green
  }
} else {
  // No fruit eaten: normal move, remove tail
  snake.removeLast();
}



    // Check if new head on fruit position already handled

    onUpdate(); // Trigger rebuild
  }

  void _handleObstacleHit() {
  if (yellowCell == null) {
    int idx = random.nextInt(snake.length);
    snake[idx].color = Colors.yellow;
    yellowCell = snake[idx].position;
    lastTailColor = Colors.yellow; // track last added color
  } else {
    int idx = snake.indexWhere((s) => s.position == yellowCell);
    if (idx != -1) {
      snake[idx].color = Colors.red;
      lastTailColor = Colors.red; // track red
    }
    yellowCell = null;
  }
}


  void _handleThreeGreens() {
    // Find a red cell and turn green
    int redIdx = snake.indexWhere((s) => s.color == Colors.red);
    if (redIdx != -1) {
      snake[redIdx].color = Colors.green;
    }
  }

  void _addRedFruits(int count) {
    for (int i = 0; i < count; i++) {
      Offset pos = _getRandomPosition(exclude: _getAllOccupied());
      fruits.add(Fruit(pos, Colors.red, false));
    }
  }

  void _addGreenFruit() {
    Offset pos = _getRandomPosition(exclude: _getAllOccupied());
    fruits.add(Fruit(pos, Colors.green, true));
  }

  Offset _getRandomPosition({Set<Offset>? exclude}) {
    Set<Offset> allExclude = _getAllOccupied();
    if (exclude != null) allExclude.addAll(exclude);
    while (true) {
      double x = random.nextInt(width).toDouble();
      double y = random.nextInt(height).toDouble();
      Offset pos = Offset(x, y);
      if (!allExclude.contains(pos)) return pos;
    }
  }

  List<Offset> _generateRandomPositions(int count,
      {required Set<Offset> exclude}) {
    List<Offset> positions = [];
    Set<Offset> allExclude = Set.from(exclude);
    for (int i = 0; i < count; i++) {
      Offset? pos;
      while (pos == null || allExclude.contains(pos)) {
        double x = random.nextInt(width).toDouble();
        double y = random.nextInt(height).toDouble();
        pos = Offset(x, y);
      }
      positions.add(pos);
      allExclude.add(pos);
    }
    return positions;
  }

  Set<Offset> _getAllOccupied() {
    Set<Offset> occupied = Set.from(snake.map((s) => s.position));
    occupied.addAll(obstacles);
    occupied.addAll(fruits.map((f) => f.position));
    return occupied;
  }

  void _gameOver() {
    _timer?.cancel();
    // Show dialog or something, but for now just stop
  }
}

class SnakeSegment {
  Offset position;
  Color color;
  SnakeSegment(this.position, this.color);
}

class Fruit {
  Offset position;
  Color color;
  bool isGreen;
  Fruit(this.position, this.color, this.isGreen);
}

class SnakePainter extends CustomPainter {
  final GameController controller;

  SnakePainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    double cellWidth = size.width / controller.width;
    double cellHeight = size.height / controller.height;
    double cellSize = min(cellWidth, cellHeight);

    // Draw grid background (optional)
    Paint gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;
    for (int x = 0; x <= controller.width; x++) {
      canvas.drawLine(Offset(x * cellSize, 0),
          Offset(x * cellSize, size.height), gridPaint);
    }
    for (int y = 0; y <= controller.height; y++) {
      canvas.drawLine(
          Offset(0, y * cellSize), Offset(size.width, y * cellSize), gridPaint);
    }

    // Draw obstacles black
    Paint obsPaint = Paint()..color = Colors.black;
    for (Offset pos in controller.obstacles) {
      Rect obsRect = Rect.fromLTWH(
          pos.dx * cellSize, pos.dy * cellSize, cellSize, cellSize);
      canvas.drawRect(obsRect, obsPaint);
    }

    // Draw fruits
    for (Fruit fruit in controller.fruits) {
      Paint fruitPaint = Paint()..color = fruit.color;
      Offset center = Offset((fruit.position.dx + 0.5) * cellSize,
          (fruit.position.dy + 0.5) * cellSize);
      canvas.drawCircle(center, cellSize * 0.4, fruitPaint);
    }

    // Draw snake
    for (SnakeSegment segment in controller.snake) {
      Paint segPaint = Paint()..color = segment.color;
      Rect segRect = Rect.fromLTWH(segment.position.dx * cellSize,
          segment.position.dy * cellSize, cellSize, cellSize);
      canvas.drawRect(segRect, segPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
