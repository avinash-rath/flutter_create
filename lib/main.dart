/* All of the code documentation is done in the mainDocumented.txt file. (Cuz file size problems...)*/
import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateOne(),
    );
  }
}

List<String> animations = [
  'assets/1.flr',
  'assets/1.flr',
  'assets/2.flr',
];
List<String> animationNames = ['Roundel - 1', 'Roundel - 2', 'star_roundel'];
List<String> names = ['Roundel - 1', 'Roundel - 2', 'star_roundel'];
var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CreateOne extends StatefulWidget {
  @override
  _CreateOneState createState() => _CreateOneState();
}

class _CreateOneState extends State<CreateOne> {
  var currentPage = animations.length - 1.0;
  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: animations.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
        backgroundColor: Color(0xFF2d3447),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
              child: Text('Choose Your ProgressIndicator',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ))),
          Stack(children: <Widget>[
            CardScrollWidget(currentPage),
            Positioned.fill(
                child: PageView.builder(
                    itemCount: animations.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    }))
          ])
        ])));
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  CardScrollWidget(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;
        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;
        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;
        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;
        List<Widget> cardList = new List();
        for (var i = 0; i < animations.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;
          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);
          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: AspectRatio(
                aspectRatio: cardAspectRatio,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: Stack(children: <Widget>[
                      FlareActor(
                        animations[i],
                        fit: BoxFit.contain,
                        animation: animationNames[i],
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, bottom: 10.0),
                                    child: Text(names[i],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                        )))
                              ]))
                    ]))),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
