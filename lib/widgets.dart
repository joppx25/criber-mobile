import 'package:flutter/material.dart';
import 'screens/profile.dart';
import 'package:criber/models/user.dart';
import "dart:math";

class ReusableWidgets {

  getAppBar(BuildContext context, String title, VoidCallback onBackPressed) {
    return AppBar(
      leading: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
      ),
      titleSpacing: 0.0,
      title: Text(title,
          style: new TextStyle(
              color: Colors.white,
              fontSize: 26
          )
      ),
    );
  }

  getMenuButton(BuildContext context, String icon, String label, VoidCallback onTapped) {
    return new SizedBox(
      width: 150,
      child: new Card (
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(width: 2.0, color: Colors.grey)
        ),
        margin: EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        child: new InkWell(
          // When the user taps the button, show a snackbar
          onTap: onTapped,
          child: new Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Image.asset(
                    "assets/icons/" + icon,
                    fit: BoxFit.cover,
                    width: 80.0,
                    height: 80,
                  ),
                  new Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(label,
                            style: new TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.normal)),
                      ]),
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget getDreamboardThumbnailLayout(DreamBoardItem item, VoidCallback onTapped) {
    return new InkWell(
      onTap: onTapped,
      child: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(item.image),
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.srcOver),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: new Text ( item.content,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  wordSpacing: 1,
                  letterSpacing: 0.5,
                  height: 1,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}

class DreamBoardItem {
  static var imageList = [
    'assets/images/dream01.jpeg',
    'assets/images/dream02.jpeg',
    'assets/images/dream03.jpeg',
    'assets/images/dream04.jpeg',
    'assets/images/dream05.jpeg',
    'assets/images/dream06.jpeg',
    'assets/images/dream07.jpeg',
    'assets/images/dream08.jpeg',
    'assets/images/dream09.jpeg',
    'assets/images/dream10.jpeg',
    'assets/images/dream11.jpeg',
    'assets/images/dream12.jpeg',
    'assets/images/dream13.jpeg',
    'assets/images/dream14.png',
    'assets/images/dream15.jpeg',
    'assets/images/dream16.jpeg',
    'assets/images/dream17.jpeg',
    'assets/images/dream18.jpg',];

  static var contentList = [
    '1.learn how to cook\n2.climb Mt. Everest\n3.start a business',
    '1.dancing\n2.become a pilot\n3.own a jet plane\n4.own a ship',
    'Success is not final; failure is not fatal: It is the courage to continue that counts.',
    'It is better to fail in originality than to succeed in imitation.',
    'There are two types of people who will tell you that you cannot make a difference in this world: those who are afraid to try and those who are afraid you will succeed.',
    'Don\'t let the fear of losing be greater than the excitement of winning.',
    'I never dreamed about success, I worked for it.',
    'Keep on going, and the chances are that you will stumble on something, perhaps when you are least expecting it. I never heard of anyone ever stumbling on something sitting down.'
  ];

  final String image;
  final String content;

  DreamBoardItem(this.image, this.content);
  // Named constructor that forwards to the default one.
  DreamBoardItem.random() : this(imageList[new Random().nextInt(imageList.length)],
      contentList[new Random().nextInt(contentList.length)]);
}
