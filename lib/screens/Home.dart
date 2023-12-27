import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
     
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Image.asset(
              'assets/inge.png',
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomRectangle(
                    width: double.infinity,
                    height: 80,
                    color: Colors.orange,
                    text: 'Hidráulica',
                    onPressed: () { Navigator.pushNamed(context, '/hidraulica'); },
                  ),
                  SizedBox(height: 20,),
                  CustomRectangle(
                    width: double.infinity,
                    height: 80,
                    color: Colors.blue,
                    text: 'Bombas',
                    onPressed: () { Navigator.pushNamed(context, '/bombas');},
                  ),
                  SizedBox(height: 20,),
                  CustomRectangle(
                    width: double.infinity,
                    height: 80,
                    color: Colors.purple,
                    text: 'Interpolador',
                    onPressed: () { Navigator.pushNamed(context, '/interpolador');},
                  ),
                  SizedBox(height: 20,),
                  CustomRectangle(
                    width: double.infinity,
                    height: 80,
                    color: Colors.green,
                    text: 'Tutoriales',
                    onPressed: () {Navigator.pushNamed(context, '/tutoriales');},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
