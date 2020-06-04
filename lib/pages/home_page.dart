import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/models/event.dart';
import 'package:ijoa/models/user.dart';
import 'package:ijoa/pages/accout_page.dart';

// pub
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/pages/info_input_views/children_input_view.dart';
import 'package:ijoa/widgets/event_tile.dart';
import 'package:ijoa/widgets/nm_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// pages
import 'calendar_page.dart';
import 'child_detail_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> _children = ['name'];
  static int _selectedIndex = 0;
  List<bool> _selections = [false];
  bool _hasPlayToday = true;
  static List<String> _playList = [
    '가족 꽃밭 만들기',
    '백화점 꾸미기',
    '거미줄 꾸미기',
    '거미줄 꾸미기',
    '목장 꾸미기'
  ];
  List<String> _currentList = [];
  // TODO: perpage를 사용 기계의 가로 길이에 따라 다르게 !
  static int _perPage = 2;
  static int _present = 0;

  @override
  void initState() {
    super.initState();
    _startInit();
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _children = prefs.getStringList('CHILDRENMETADATA');
      _selections = List<bool>.generate(_children.length, (_) => false);
      _selections[0] = true;

      _currentList.addAll(_playList.getRange(_present, _present + _perPage));
    });
    debugPrint('currentList: $_currentList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildAppBar(),
              SizedBox(height: 8.0),
              _buildTitle(title: '오늘 해야할 놀이'),
              _getPlaysToday(),
              SizedBox(height: 36.0),
              _buildTitle(title: '아이들에 대해 한눈에 알아보세요'),
              _buildToggleChildren(),
              Divider(
                height: 0.0,
              ),
              _getChildOverview(childMetaData: _children[_selectedIndex]),
              SizedBox(height: 36.0),
              _buildTitle(title: '아동인지 알아보기'),
              _buildInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.headline4,
                  children: [
                TextSpan(text: '안녕하세요, '),
                TextSpan(
                    text: '${widget.user.name}',
                    style: TextStyle(color: Colors.yellow.shade800)),
                TextSpan(text: '님'),
              ])),
          Row(
            children: <Widget>[
              NMButton(
                icon: Icons.account_circle,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AccountPage(
                                user: widget.user,
                              )));
                },
              ),
              SizedBox(width: 4),
              NMButton(
                hasBadge: _hasPlayToday,
                icon: Icons.calendar_today,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalendarPage())),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitle({String title}) {
    return Container(
      margin: EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget _getPlaysToday() {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _playList.length,
        itemBuilder: (BuildContext context, int index) {
          return EventTile(
            event: eventModelList[index],
          );
        },
      ),
    );
  }

  Widget _buildToggleChildren() {
    return Row(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              renderBorder: false,
              isSelected: _selections,
              selectedColor: Colors.grey.shade700,
              // fillColor: Colors.transparent,
              color: Colors.black12,
              children: _children
                  .map((e) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        e.split('/')[0] ?? 'name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 6),
                      )))
                  .toList(),
              onPressed: (int index) {
                List<bool> _reset =
                    List<bool>.generate(_children.length, (_) => false);
                setState(() {
                  _selections = _reset;
                  _selections[index] = true;
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewChildren(
                          initialPage: _children.length,
                        )));
          },
        )
      ],
    );
  }

  Widget _getChildOverview({@required String childMetaData}) {
    bool _isAvaiable = childMetaData != 'name';
    int _indexLastTested = _isAvaiable ? 1 : 0;
    int _indexLastPlayed = _isAvaiable ? 2 : 0;
    List<String> _metaData = childMetaData.split('/');
    String _name = _metaData[0];
    debugPrint('_getChildOverview: $childMetaData');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: ListTile(
              title: Text('$_name에 대해 알아본 날',
                  style: Theme.of(context).textTheme.bodyText1),
              subtitle: Text(_metaData[_indexLastTested]),
              trailing: FlatButton(
                child: Text('자세히'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildDetailPage(
                              name: _name,
                              childTag: 'CHILDINDEX$_selectedIndex',
                            )),
                  );
                },
                textColor: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            child: ListTile(
              title: Text('$_name와 논 날',
                  style: Theme.of(context).textTheme.bodyText1),
              subtitle: Text(_metaData[_indexLastPlayed]),
              trailing: FlatButton(
                child: Text('자세히'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildDetailPage(
                              name: _name,
                              childTag: 'CHILDINDEX$_selectedIndex',
                            )),
                  );
                },
                textColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.only(bottom: 40.0),
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
    );
  }
}

class NewChildren extends StatelessWidget {
  final int initialPage;

  const NewChildren({Key key, this.initialPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ChildrenInputView(initialPage: initialPage)),
    );
  }
}
