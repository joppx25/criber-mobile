import 'package:flutter/material.dart';
import '../widgets.dart';
import 'package:criber/models/user.dart';
import 'package:criber/services/user_management.dart';
import 'dreamboarddetails.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() {
    return ProfileState();
  }
}

final double profileWidth = 360;
final double profileHeight = 360;

class ProfileState extends State<Profile> {
  final _userManagement = new UserManagement();

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: this._userManagement.getUserData(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          User user = snapshot.data;

          return snapshot.hasData
              ?
          // Scaffold is a layout for the major Material Components.
          new Scaffold(
              appBar: new ReusableWidgets().getAppBar(
                  context, "Profile", () => Navigator.pop(context)),
              body: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                      child: new Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: new Stack(
                          children: <Widget>[
                            new Align(
                              alignment: Alignment.center,
                              child: new Container(
                                width: profileWidth,
                                height: profileHeight,
                                child: new Padding(
                                  padding: EdgeInsets.only(top: profileWidth / 2),
                                  child: new Container(
                                      width: profileWidth,
                                      height: profileHeight / 2,
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18.0),
                                            bottomRight: Radius.circular(18.0)),
                                        color: Colors.white,
                                      ),
                                      child: new Padding(
                                        padding: EdgeInsets.only(top: 50),
                                        child: new Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Center(
                                              child: new Padding(
                                                child: new Text(
                                                  "${user.name}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .title,
                                                ),
                                                padding:
                                                EdgeInsets.only(bottom: 12),
                                              ),
                                            ),
                                            new Align(
                                              alignment: Alignment.topLeft,
                                              child: new Text(
                                                "* Stays at ${user.currentAddress}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .body2,
                                              ),
                                            ),
                                            new Align(
                                              alignment: Alignment.topLeft,
                                              child: new Text(
                                                "* Born on ${user.birthday}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .body2,
                                              ),
                                            ),
                                            new Align(
                                              alignment: Alignment.topLeft,
                                              child: new Text(
                                                "* Works at ${user.workplace}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .body2,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                decoration: new BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(18.0)),
                                ),
                              ),
                            ),
                            new Padding(
                                padding: EdgeInsets.only(top:profileHeight/2-85/2),
                                child: new Align(
                                    alignment: Alignment.center,
                                    child: new CircleAvatar(
                                        radius: 45,
                                        child: user.profilePhoto != ''
                                            ? new ClipOval(
                                            child: Image.network(
                                              user.profilePhoto,
                                              fit: BoxFit.cover,
                                              width: 85,
                                              height: 85,
                                            ))
                                            : new Icon(
                                          Icons.account_circle,
                                          size: 85,
                                        )))
                            )

                          ],
                        ),
                      )
                  ),
                  new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          primary: false,
                          padding: const EdgeInsets.all(16.0),
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          crossAxisCount: 1,
                          children: List.generate(_list.length, (index) {
                            return new ReusableWidgets().getDreamboardThumbnailLayout(_list[index],
                                  () => {}
                          );
                          }),
                        ),
                      )
                  ),
                ],
              )
          )
              : new Center(
            child: new SizedBox(
              height: 50.0,
              width: 50.0,
              child: new CircularProgressIndicator(
                backgroundColor: Color(0xFFFFFFFF),
                value: null,
                strokeWidth: 5.0,
              ),
            ),
          );
        });
  }

  List<DreamBoardItem> _list;

  @override
  void initState() {
    init();
  }

  void init() {
    _list = List<DreamBoardItem>.generate(
      15,
          (i) => DreamBoardItem.random(),
    );
  }

}
