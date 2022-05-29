import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

const mainColor = Color(0xff6524FF);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    const paddingVal = 20.0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 45.0, bottom: paddingVal, right: paddingVal, left: paddingVal),
        child: Column(
          children: <Widget>[
            _buildTop(),
            _buildEmptyHeightSpace(),
            Text(
              '모든 알람이 꺼진\n상태입니다',
              style: TextStyle(
                fontSize: 35.0,
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            _buildEmptyHeightSpace(),

            _buildAlarm(),
            _buildEmptyHeightSpace(),
            _buildAlarm(),
            _buildEmptyHeightSpace(),
            _buildAlarm(),
            _buildEmptyHeightSpace(),
            _buildAlarm(),


          ],
        ),
      ),

      floatingActionButton: SpeedDial( //Speed dial menu
        tooltip: '알람 추가',
        icon: Icons.add, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: mainColor, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor: mainColor, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56.0, 56.0), //button size
        visible: true,  // ?
        closeManually: false, // ?
        curve: Curves.bounceIn, // ?
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'), // action when menu opens
        onClose: () => print('DIAL CLOSED'), //action when menu closes

        elevation: 8.0, //shadow elevation of button
        shape: CircleBorder(), //shape of button

        children: <SpeedDialChild>[
          SpeedDialChild( //speed dial child
            child: Icon(Icons.alarm),
            backgroundColor: mainColor,
            foregroundColor: Colors.white,
            label: '알람',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('알람 추가 버튼 클릭됨'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: mainColor,
            foregroundColor: Colors.white,
            label: '퀵 알람',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('퀵 알람 추가 버튼 클릭됨'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
        ],
      ),
    );

  }

  Widget _buildTop() {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Kant',
        style: TextStyle(
          fontSize: 50.0,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyHeightSpace() {
    return const SizedBox(
      height: 35.0,
    );
  }

  Widget _buildEmptyWidthSpace() {
    return const SizedBox(
      width: 20.0,
    );
  }

  // Alarm Info 시작
  // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  Widget _buildAlarm() {
    return Row(
      children: <Widget>[
        _buildAlarmDeco(),
        _buildEmptyWidthSpace(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAlarmInfo_time(),
            _buildAlarmLabel(),
            _buildAlarmInfo_day(),
          ],
        ),
        _buildEmptyWidthSpace(),
        _buildAlarmSwitch(),
      ],
    );
  }

  Widget _buildAlarmDeco() {
    return Column(
      children: const <Widget>[
        Text('⦁'),
        Text('⋮'),
        Text('⋮'),
        Text('⋮'),
      ],
    );
  }

  Widget _buildAlarmInfo_time() {
    return Text(
      '오전 00시 00분',
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAlarmLabel() {
    return Text(
      '#1교시 시작시간',
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  Widget _buildAlarmInfo_day() {
    const size = 25.0;
    return Row(
      children: ['월', '화', '수', '목', '금', '토', '일'].map(
        (day) => Container(
          margin: EdgeInsets.all(4.5),
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: mainColor,
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildAlarmSwitch() {
    bool isSwitched = false;  // State<MainPage> 의 프로퍼티로 위치해야함
    return Transform.scale(
      scale: 1.5,
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
      ),
    );
  }

}
