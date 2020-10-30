import 'package:flutter/material.dart';

import '../widgets/head_bar.dart';

class LandingPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          HeadBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 2900,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
