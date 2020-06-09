import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/models/event.dart';
import 'package:ijoa/models/user.dart';
import 'package:ijoa/pages/accout_page.dart';
import 'package:ijoa/pages/add_play_page.dart';

// pub
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/pages/info_input_views/children_input_view.dart';
import 'package:ijoa/widgets/custom_radar_chart.dart';
import 'package:ijoa/widgets/event_tile.dart';
import 'package:ijoa/widgets/nm_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// pages
import 'calendar_page.dart';
import 'child_detail_page.dart';

class HomePage extends StatefulWidget {
  final User user;
  final List<String> eventsToday;

  const HomePage({Key key, this.user, this.eventsToday}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> _children = ['name'];
  static int _selectedIndex = 0;
  List<bool> _selections = [false];
  bool _hasPlayToday = true;

  List<String> _eventsToday = [];

  @override
  void initState() {
    super.initState();
    _eventsToday = widget.eventsToday ?? [];
    _startInit();
  }

  void _startInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _eventsToday =
        prefs.getStringList('${DateTime.now().toString().split(' ')[0]}') ?? [];
    setState(() {
      List<String> _result = prefs.getStringList('CHILDRENMETADATA');
      _children = _result;
      _selections = List<bool>.generate(_children.length, (_) => false);
      _selections[0] = true;
    });
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
                          builder: (_) => AccountPage(user: widget.user)));
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
        cacheExtent: _eventsToday.length * 210.0,
        scrollDirection: Axis.horizontal,
        itemCount: _eventsToday.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _eventsToday.length)
            return Container(
              width: 210,
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: GestureDetector(
                onTap: () async {
                  debugPrint('add play today!');
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AddPlayPage()));
                  _startInit();
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(32.0),
                  strokeCap: StrokeCap.round,
                  dashPattern: [4, 4],
                  strokeWidth: 2,
                  color: Colors.grey.shade400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              '놀이 추가',
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          return EventTile(
            // indexToName: _childrenName,
            index: index,
            event: _eventsToday[index],
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
        // TODO: child add ! ! 
        // IconButton(
        //   icon: Icon(Icons.add),
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (_) => NewChildren(
        //                   initialPage: _children.length,
        //                 )));
        //   },
        // )
      ],
    );
  }

  Widget _getChildOverview({@required String childMetaData}) {
    bool _isAvaiable = childMetaData != 'name';
    int _resultLastTested = _isAvaiable ? 1 : 0;
    int _indexLastTested = _isAvaiable ? 2 : 0;
    List<String> _metaData = childMetaData.split('/');
    String _name = _metaData[0];
    debugPrint('_getChildOverview: $childMetaData');
    if (_metaData[_resultLastTested] == '아직 없습니다')
      return Container(
          height: 56.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.pinkAccent,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '첫번째 테스트를 시작하세요!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              OutlineButton(
                child: Text('시작하기'),
                color: Colors.white,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                highlightedBorderColor: Colors.white,
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildDetailPage(
                              childTag: 'CHILDINDEX$_selectedIndex',
                            )),
                  );
                  _startInit();
                },
              )
            ],
          )));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 12),
          CustomPaint(
            size: Size(200, 200),
            painter: RadarChartPainter(
                scores: _metaData[_resultLastTested].split(',').map((e) {
              return double.tryParse(e);
              // return double.parse(e);
            }).toList()),
          ),
          SizedBox(height: 12),
          Container(
            child: ListTile(
              title: Text('$_name에 대해 알아본 날',
                  style: Theme.of(context).textTheme.bodyText1),
              subtitle: Text(_metaData[_indexLastTested]),
              trailing: FlatButton(
                child: Text('자세히'),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildDetailPage(
                              childTag: 'CHILDINDEX$_selectedIndex',
                            )),
                  );
                  _startInit();
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
