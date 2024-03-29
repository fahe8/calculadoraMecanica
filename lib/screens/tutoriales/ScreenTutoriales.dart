import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoList extends StatelessWidget {
  final List<String> videoLinks = [
    'https://www.youtube.com/watch?v=E_gEjI_Vwsc&t=171s&ab_channel=HidráulicaMecánica',
    'https://www.youtube.com/watch?v=vel4Os4tcQ0&ab_channel=HidráulicaMecánica',
    'https://www.youtube.com/watch?v=LBfsJjXTovA&ab_channel=HidráulicaMecánica',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF52C2D31) ,
      appBar: MyAppBar(
          title: 'Tutoriales',
          backgroundColor: Colors.green,
          routeBack: () {
            Navigator.pushNamed(context, '/home');
          }),
      body: ListView.builder(
        itemCount: videoLinks.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xF52C2D31),
            child: InkWell(
              onTap: () {
                // Abre el enlace en la aplicación de YouTube
                launchYouTubeVideo(videoLinks[index]);
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/video${index+1}.png',
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.fitWidth,
                      ),
                      
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  void launchYouTubeVideo(String videoLink) async {
    if (await canLaunch(videoLink)) {
      await launch(videoLink);
    } else {
      throw 'No se puede abrir el enlace $videoLink';
    }
  }
}
