import 'package:flutter/material.dart';
import 'package:ijoa/models/user.dart';
import 'package:ijoa/pages/init_page.dart';
import 'package:ijoa/widgets/custom_app_bar.dart';
import 'package:ijoa/widgets/nm_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatelessWidget {
  final User user;

  const AccountPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            NMAppBar(
              title: Text(
                '계정 정보',
                style: Theme.of(context).textTheme.headline4,
              ),
              trailingIcon: Icons.close,
              trailingTooltip: '닫기',
              trailingOnTap: () => Navigator.pop(context),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('이름'),
                    trailing: Text(user.name),
                  ),
                  ListTile(
                    title: Text('생일'),
                    trailing: Text(user.birthday),
                  ),
                  ListTile(
                    title: Text('구분'),
                    trailing: Text(user.momOrDad),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36.0,
            ),
            NMTextButton(
              text: '전체 초기화',
              onTap: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                await _prefs.clear();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => InitPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
