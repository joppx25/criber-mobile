import 'package:flutter/material.dart';
import 'customStateWithFutureBuilder.dart';
import 'screens/profile.dart';
import 'package:criber/models/user.dart';
import 'package:criber/services/user_management.dart';

class HomeBar extends StatefulWidget {
  User _user = new User();
  final _userManagement = new UserManagement();

  String title;
  bool hasAdd;
  VoidCallback onPress;
  HomeBar(this.title, this.hasAdd, this.onPress);

  @override
  _homeBarState createState() => new _homeBarState();

}

class _homeBarState extends CustomState<HomeBar> {

  @override
  Future<bool> loadWidget(BuildContext context, bool isInit) async {
    if (isInit) {
      Future<User> futureUser = widget._userManagement.getUserData();
      widget._user = await futureUser;
    }

    return true;
  }

  @override
  Widget customLoader(BuildContext context) {
    return AppBar(
      leading: new Padding(
        padding: const EdgeInsets.all(0.0),
        child: new InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          ),
          child: new CircleAvatar(
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
      title: Text(widget.title,
          style: new TextStyle(
              color: Colors.white,
              fontSize: 26
          )
      ),
      actions: getAction(widget.onPress),
    );
  }

  @override
  Widget customBuild(BuildContext context) {
    return AppBar(
      leading: new Padding(
        padding: const EdgeInsets.all(0.0),
        child: new InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          ),
          child: new CircleAvatar(
            child: widget._user.profilePhoto != null
                ? new ClipOval(
                child: Image.network(
                  widget._user.profilePhoto,
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ))
                : new Icon(
              Icons.account_circle,
              size: 45,
            ),
          ),
        ),
      ),
      title: Text(widget.title,
          style: new TextStyle(
              color: Colors.white,
              fontSize: 26
          )
      ),
      actions: getAction(widget.onPress),
    );
  }

  List<Widget> getAction(VoidCallback onActionPressed) {
    if (widget.hasAdd) {
      return
        <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 35,
            onPressed: onActionPressed,
          )
        ];
    }
  }

}
