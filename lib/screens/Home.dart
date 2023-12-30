import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

   @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: SafeArea(
          child: Container(
               
                child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/inge.png',
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomRectangle(
                      width: double.infinity,
                      height: 80,
                      color: ColoresApp.hidraulica,
                      text: 'Hidráulica',
                      onPressed: () { Navigator.pushNamed(context, '/hidraulica'); },
                    ),
                    SizedBox(height: 20,),
                    CustomRectangle(
                      width: double.infinity,
                      height: 80,
                      color: ColoresApp.bombas,
                      text: 'Bombas',
                      onPressed: () { Navigator.pushNamed(context, '/bombas');},
                    ),
                    SizedBox(height: 20,),
                    CustomRectangle(
                      width: double.infinity,
                      height: 80,
                      color: ColoresApp.interpolador,
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
              ),
        ));
  }
}
