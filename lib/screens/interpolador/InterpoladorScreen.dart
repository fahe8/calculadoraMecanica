import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InterpoladorScreen extends StatefulWidget {
  const InterpoladorScreen({Key? key}) : super(key: key);

  @override
  _InterpoladorScreenState createState() => _InterpoladorScreenState();
}

class _InterpoladorScreenState extends State<InterpoladorScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Interpolador',
        backgroundColor: Colors.orange,
        routeBack: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(

            children: [
              Row(
                children: [
                  rectanguloCoordenada(),
                  rectanguloCoordenada(),
                ],
              ),
              Row(
                children: [
                  rectanguloCoordenada(),
                  rectanguloCoordenada(),
                ],
              ),
              Row(
                children: [
                  rectanguloCoordenada(),
                  rectanguloCoordenada(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rectanguloCoordenada() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          width: 40,
          child: Center(child: Text('X0')),
        ),
       
        Container(
          width: 130,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                },
                icon: Icon(Icons.clear),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
