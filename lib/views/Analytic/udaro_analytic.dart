import 'package:bayapar_retailer/consts/colors.dart';
import 'package:bayapar_retailer/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widget/data_model.dart';

class Udaro_analytic extends StatefulWidget {
  @override
  State<Udaro_analytic> createState() => _Udaro_analyticState();
}

class _Udaro_analyticState extends State<Udaro_analytic> {
  List<DataModel> _list = List<DataModel>.empty(growable: true);
  String _selectedPeriod = 'This week';
  List<String> _periods = ['This week', 'This month'];
  @override
  void initState() {
    super.initState();
    _list.add(DataModel(key: "", value: "2"));
    _list.add(DataModel(key: "", value: "4"));
    _list.add(DataModel(key: "", value: "6"));
    _list.add(DataModel(key: "", value: "8"));
    _list.add(DataModel(key: "", value: "10"));
    _list.add(DataModel(key: "", value: "8"));
    _list.add(DataModel(key: "", value: "4"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text("Udaro Analysis",style: TextStyle(color: darkFontGrey),),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey, // set icon color to black
        ),
      ),
      body: SingleChildScrollView(
        child: Container(color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Udaro Analysis",style: TextStyle(fontSize: 20,fontFamily: bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: _selectedPeriod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPeriod = value!;
                      });
                    },
                    items: _periods.map((period) {
                      return DropdownMenuItem(
                        value: period,
                        child: Text(period),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height*0.2,
                  width: 200,
                  child: BarChart(
                    BarChartData(
                      backgroundColor: Colors.white,
                      barGroups: _chartGroups(),
                      borderData: FlBorderData(
                          border: const Border(bottom: BorderSide(), left: BorderSide())),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toString(),
                                  style: const TextStyle(fontSize: 10),
                                );
                              },
                            )),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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

  List<BarChartGroupData> _chartGroups() {
    List<BarChartGroupData> list =
    List<BarChartGroupData>.empty(growable: true);
    for (int i = 0; i < _list.length; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
            toY: double.parse(_list[i].value!), color: Colors.deepOrange)
      ]));
    }
    return list;
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = 'Mon';
          break;
        case 1:
          text = 'Tue';
          break;
        case 2:
          text = 'Wed';
          break;
        case 3:
          text = 'Thu';
          break;
        case 4:
          text = 'Fri';
          break;
        case 5:
          text = 'Sat';
          break;
        case 6:
          text = 'Sun';
          break;
      }

      return Text(
        text,
        style: TextStyle(fontSize: 10),
      );
    },
  );
}