import 'package:event_calender/widgets/test_sticky_widget.dart';
import 'package:flutter/material.dart';

class TestStickyHeader extends StatelessWidget {
  const TestStickyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Sticky Header Example'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return TestStickyWidget(
                      header: 'Header $index', content: 'Content $index');
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      );
  }
}

