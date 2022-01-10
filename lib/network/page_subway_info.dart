import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api/subway_api.dart' as api;
import 'model/subway_arrival.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  TextEditingController _stationController =
      TextEditingController(text: api.defaultStation);
  List<SubwayArrival> _data = [];
  bool _isLoading = false;

  List<Card> _buildCards() {
    print('>>> _data.length? ${_data.length}');

    if (_data.isEmpty) {
      return <Card>[];
    }

    List<Card> res = [];
    for (SubwayArrival info in _data) {
      Card card = Card(
        child: Column(
          children: <Widget>[
            AspectRatio(aspectRatio: 18 / 11,
            child: Image.asset(
              'assets/icon/subway.png',
              fit: BoxFit.fitHeight,
            ),),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      info.trainLineNm,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0,),
                    Text(
                      info.arvlMsg2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
      res.add(card);
    }

    return res;
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  _onClick() {
    _getInfo();
  }

  _getInfoErrorFlow(String errorMsg) {
    setState(() {
      print('error >> $errorMsg');
      _data = const [];
      _isLoading = false;
    });
  }

  _getInfo() async {
    setState(() => _isLoading = true);

    String station = _stationController.text;
    var response = await http.get(Uri.parse(api.buldUrl(station)));
    String responseBody = response.body;
    print('res >> $responseBody');

    var json = jsonDecode(responseBody);
    Map<String, dynamic> errorMessage = json['errorMessage'];

    try {
      if (errorMessage['status'] != api.STATUS_OK) {
        _getInfoErrorFlow(errorMessage['message']);
        return;
      }
    } on NoSuchMethodError {
      _getInfoErrorFlow(json['message']);
      return;
    }


    List<dynamic> realtimeArrivalList = json['realtimeArrivalList'];
    final int cnt = realtimeArrivalList.length;

    List<SubwayArrival> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = realtimeArrivalList[i];
      return SubwayArrival(
        item['rowNum'],
        item['subwayId'],
        item['trainLineNm'],
        item['subwayHeading'],
        item['arvlMsg2'],
      );
    });

    setState(() {
      _data = list;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('지하철 실시간 정보'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            child: Row(
              children: <Widget>[
                const Text('역 이름'),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 150,
                  child: TextField(
                    controller: _stationController,
                  ),
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                ElevatedButton(
                  child: const Text('조회'),
                  onPressed: _onClick,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text('도착 정보'),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              children: _buildCards(),
            ),
          )
        ],
      ),
    );
  }
}