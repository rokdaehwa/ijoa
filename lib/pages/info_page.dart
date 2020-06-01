import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/widgets/nm_icon_button.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  NMButton(
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.amber[100],
              margin: EdgeInsets.only(top: 8.0, bottom: 40.0),
              child: Center(
                child: Text(
                  '아동 인지 알아보기',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text('아동 인지 알아보기'),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: ConcaveDecoration(
                        depth: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    child: ListTile(
                      title: Text('아동 인지 능력의 종류'),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    title: '아동 인지 능력의 종류',
                                    url:
                                        'https://www.notion.so/1b3405c753af47028ce8847b003d4be9',
                                  ))),
                      leading: Icon(Icons.help_outline),
                      trailing: Icon(Icons.navigate_next),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: ConcaveDecoration(
                        depth: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    child: ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    title: '아동 인지의 중요성',
                                    url:
                                        'https://www.notion.so/f238cfe7b9624d53b0df5dcd56a2802b',
                                  ))),
                      title: Text('아동 인지의 중요성'),
                      leading: Icon(Icons.help_outline),
                      trailing: Icon(Icons.navigate_next),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
