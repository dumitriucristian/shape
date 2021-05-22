import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
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
    //de ce aici e ok?
    //Cube _cube = new Cube(number:4);

    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Number shapes')

      ),
      body: Column(
        children: [
          Text('Pleas input some number to see if it is square or triangular'),
          TextFormField(
            controller: _controller,
            ),
          ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
           String validate = validateInput(_controller.text);
           if( null != validate) {
             showDialog(context: context,
                 builder: (BuildContext context) => AlertDialog(
                  title: Text("$validate"),
                  actions: [
                     TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                          _controller.clear();
                        },
                        child: Text('Try again'),
                      ),
                    ]
               ),
             );
           }else{

             int _number =  num.parse(_controller.text);
              Cube _cube = Cube(number: _number);
               Triangle _triangle = Triangle(number: _number);
              bool _isCube = _cube.isValidShape();
              bool _isTriangle = _triangle.isValidShape();
              print(_isTriangle);
              String _message = checkShape(_isCube, _isTriangle, _number);

              showDialog(context: context,
               builder: (BuildContext context) => AlertDialog(
                   title: Text("$_message"),
                   actions: [
                     TextButton(
                       onPressed: () {
                         Navigator.pop(context, 'Cancel');
                         _controller.clear();
                       },
                       child: Text('Try again'),
                     ),
                   ]
               ),
             );
           };
        },
      ),
    );
  }
}

String checkShape(bool cube, bool triangle, number)
{
  if((cube == true) && (triangle == true)) {
    return "Number $number is triangle and cube";
  }else if( (cube == false) && (triangle == true) ){
    return "Number $number is triangle";
  }else if( (cube == true) && (triangle == false)){
    return "Number $number is cube";
  }else if( (cube == false) && (triangle == false)){
    return "Number $number is neither cube or triangle";
  }else{
    return "Nasty logic with nasty results happened";
  }
}


String validateInput(String value) {
  final number = num.tryParse(value);
  if(value.isEmpty || number == null) {
    return 'Please use only numbers';
  }
  return null;
}


abstract class GeometricShape{
   isValidShape();
}

class Cube implements GeometricShape {
  int number;
  int _counter = 0;
  int _product = 0;
  Cube({this.number});

  bool isValidShape() {
    while(_product < number) {
      _product = _counter * _counter * _counter;
      _counter++;
      if(_product == number) {
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
    while(_sum < number) {
        this._sum = _sum + (_counter +1);
        ++_counter;
        print(_sum);
      if(_sum == number) {
        return true;
      }
    }
    return false;
  }
}