import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(title: 'Shape', home: Shape()),
  );
}

class Shape extends StatefulWidget {
  const Shape({Key? key}) : super(key: key);

  @override
  _ShapeState createState() => _ShapeState();
}

class _ShapeState extends State<Shape> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Number shapes')),
      body: Column(
        children: <Widget>[
          const Text('Pleas input some number to see if it is square or triangular'),
          TextFormField(
            controller: _controller,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final bool validate = validateInput(_controller.text);

          if (validate != true) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(title: const Text('Please use only numbers'), actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                    _controller.clear();
                  },
                  child: const Text('Try again'),
                ),
              ]),
            );
          }

          if (validate == true) {
            final int _number = int.parse(_controller.text);
            final Cube _cube = Cube(number: _number);
            final Triangle _triangle = Triangle(number: _number);
            final bool _isCube = _cube.isValidShape();
            final bool _isTriangle = _triangle.isValidShape();
            final String _message = checkShape(_isCube, _isTriangle, _number);

            showDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(title: Text(_message), actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                    _controller.clear();
                  },
                  child: const Text('Try again'),
                ),
              ]),
            );
          }
        },
      ),
    );
  }
}

String checkShape(bool cube, bool triangle, int number) {
  if ((cube == true) && (triangle == true)) {
    return 'Number $number is triangle and cube';
  } else if ((cube == false) && (triangle == true)) {
    return 'Number $number is triangle';
  } else if ((cube == true) && (triangle == false)) {
    return 'Number $number is cube';
  } else if ((cube == false) && (triangle == false)) {
    return 'Number $number is neither cube or triangle';
  } else {
    return 'Nasty logic with nasty results happened';
  }
}

bool validateInput(String value) {
  final num? number = num.tryParse(value);
  if ((value.isNotEmpty) || (number != null)) {
    return true;
  }
  return false;
}

abstract class GeometricShape {
  bool isValidShape();
}

class Cube implements GeometricShape {
  Cube({required this.number});

  int number;
  int _counter = 0;
  int _product = 0;

  @override
  bool isValidShape() {
    while (_product < number) {
      _product = _counter * _counter * _counter;
      _counter++;
      if (_product == number) {
        return true;
      }
    }
    return false;
  }
}

class Triangle implements GeometricShape {
  Triangle({required this.number});

  int number;
  int _counter = 0;
  int _sum = 0;

  @override
  bool isValidShape() {
    while (_sum < number) {
      _sum = _sum + (_counter + 1);
      ++_counter;
      print(_sum);
      if (_sum == number) {
        return true;
      }
    }
    return false;
  }
}
