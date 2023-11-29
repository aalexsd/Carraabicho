import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> images = [
    'assets/images/vacinas.png',
    'assets/images/racao.png',
    'assets/images/cuidados.png',
    'assets/images/banho.png',
  ];

  final List<String> urls = [
    'https://www.proteste.org.br/animais-de-estimacao/caes/noticia/saiba-quais-vacinas-seu-pet-deve-receber',
    'https://www.petlove.com.br/cachorro/racoes',
    'https://www.petlove.com.br/dicas/cuidados-pos-castracao-de-caes-e-gatos',
    'https://petshoppertodemim.com/',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 170,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        disableCenter: true,
        enlargeCenterPage: false,
      ),
      items: images.asMap().entries.map((entry) {
        int idx = entry.key;
        String imagePath = entry.value;

        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebViewPage(url: urls[idx])),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4), // Cor e opacidade da sombra
                      blurRadius: 4, // Raio do desfoque da sombra
                      offset: Offset(0, 4), // Posição da sombra (x, y)
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ),
      ),
    );
  }
}
