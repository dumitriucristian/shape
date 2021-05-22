import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
       title: "Shape",
       home: Shape()
    ),
  );
}

class Shape extends StatefulWidget {
  const Shape({Key key}) : super(key: key);

 // cube.isValidType();

  @override
  _ShapeState createState() => _ShapeState();
}

class _ShapeState extends State<Shape> {


  //de ce utilizarea codului aici arunca eroarea
  // Cube _cube = new Cube(number:4);
  //   _cube.isValidShape();
  //22:3: Error: The name of a constructor must match the name of the enclosing class.
  //17:32: Error: Method not found: '_ShapeState'.
  @override
  Widget build(BuildContext context) {
    //de ce aici e ok
    Cube _cube = new Cube(number:4);
    //print(_cube.number);
   // print(_cube.isValidShape());
    Triangle _triangle = new Triangle(number:4);
   // print(_triangle.number);
   // print(_triangle.isValidShape());
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Number shapes')

      ),
      body: Column(
        children: [
          Text('some text'),
          TextFormField(
            controller: _controller,
            ),
          ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        validateInput(_controller.text);
      }),
    );
  }
}

String validateInput(String value) {
  final number = num.tryParse(value);
  if(value.isEmpty || number == null) {
    print( 'Please use only numbers');
  }
  return null;
}


abstract class GeometricShape{
   isValidShape();
}

class Cube implements GeometricShape {
  int number;
  int _counter = 0;

  Cube({this.number});

  bool isValidShape() {
    while(_counter < number) {
      int product = _counter * _counter;
      _counter++;
      if(product == number) {
        return true;
      }
    }
    return false;
  }
}

class Triangle implements GeometricShape {
  int number;
  int _counter = 0;
  int _sum = 0;
  Triangle({this.number});

  bool isValidShape(){
    while(_counter < number) {
      int _sum = _counter + 1;
      _counter++;
      if(_sum == number) {
        return true;
      }
    }
    return false;
  }
}

