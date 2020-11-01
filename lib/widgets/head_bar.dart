import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import '../provider/auth.dart';

class HeadBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _SliverDelegate(
        child: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    SizedBox(
                      width: 9,
                    ),
                    CircleAvatar(
                      // backgroundImage: AssetImage(
                      //   'assets/images/rail_icon.png',
                      // ),
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/train.png',
                        fit: BoxFit.contain,
                      ),
                      maxRadius: 23,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        html.window.location.reload();
                        Navigator.of(context).pushReplacementNamed('/home');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Railway Reservation System',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  child: InkWell(
                    hoverColor: Colors.grey[400],
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 280,
                    margin: EdgeInsets.only(
                      right: 17,
                      bottom: 17,
                      top: 17,
                    ),
                    child: RaisedButton(
                      onPressed: () async {
                        !Provider.of<Auth>(context, listen: false).isAuth
                            ? Provider.of<Auth>(context, listen: false)
                                .authenticate()
                                .then((_) => html.window.location.reload())
                            : Provider.of<Auth>(context, listen: false).signOut().then((_) {
                                html.window.location.reload();
                              });
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            width: 35,
                            height: 35,
                            child: Image.asset(
                              'assets/images/google.png',
                            ),
                          ),
                          FittedBox(
                            child: FutureBuilder(
                              future: Provider.of<Auth>(context, listen: false).autoLogin(),
                              builder: (ctx, snapshot) {
                                print(snapshot.connectionState);
                                if (snapshot.connectionState != ConnectionState.waiting) {
                                  if (snapshot.data)
                                    return Text(
                                      ' SIGN OUT  ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    );
                                  else
                                    return Text(
                                      ' SIGN IN WITH GOOGLE  ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    );
                                } else
                                  return Text(' ');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverDelegate implements SliverPersistentHeaderDelegate {
  _SliverDelegate({
    this.minHeight = 60.0,
    this.maxHeight = 70.0,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;
  @override
  double get minExtent => minHeight;
  @override
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => null;

  @override
  TickerProvider get vsync => null;
}
