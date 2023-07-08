import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:syncfusion_officechart/officechart.dart';

class EXLChart extends StatefulWidget {
  const EXLChart({super.key});

  @override
  State<EXLChart> createState() => _EXLChartState();
}

class _EXLChartState extends State<EXLChart> {
  createExlChart()async{
    print("test2");
    // Create a new Excel document.
final Workbook workbook = Workbook();
print("test3");
// Accessing worksheet via index.
final Worksheet sheet = workbook.worksheets[0];
print("test4");
// Setting value in the cell.
sheet.getRangeByName('A11').setText('Venue');
sheet.getRangeByName('A12').setText('Seating & Decor');
sheet.getRangeByName('A13').setText('Technical Team');
sheet.getRangeByName('A14').setText('performers');
sheet.getRangeByName('A15').setText('performer\'s Transport');
sheet.getRangeByName('B11:B15').numberFormat = '\$#,##0_)';
sheet.getRangeByName('B11').setNumber(17500);
sheet.getRangeByName('B12').setNumber(1828);
sheet.getRangeByName('B13').setNumber(800);
sheet.getRangeByName('B14').setNumber(14000);
sheet.getRangeByName('B15').setNumber(2600);
print("test5");
// Create an instances of chart collection.
final ChartCollection charts = ChartCollection(sheet);
print("test6");
// Add the chart.
final Chart chart1 = charts.add();
print("test7");
// Set Chart Type.
chart1.chartType = ExcelChartType.pie;
print("test8");
// Set data range in the worksheet.
chart1.dataRange = sheet.getRangeByName('A11:B15');
print("test9");
chart1.isSeriesInRows = false;
print("test10");
// set charts to worksheet.
sheet.charts = charts;
print("test11");
// save and dispose the workbook.
List<int> bytes = workbook.saveAsStream();
print("test12");
workbook.dispose();
print("test13");

final directory = await getApplicationSupportDirectory();
print("test14");
    final file = File('${directory.path}/Output.xlsx');
    print("test15");
    await file.writeAsBytes(bytes, flush: true);
    print("test16");
    OpenFile.open(file.path);
    print("test17");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          print("test");
          createExlChart();
        }, child:const Text("Chart")),
      ),
    );
  }
}