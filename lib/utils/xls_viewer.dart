import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'base_class.dart';

class XlsViewer extends StatefulWidget {
  final String xlsUrl;
  final String isPrivate;

  const XlsViewer(this.xlsUrl,this.isPrivate,  {Key? key}) : super(key: key);

  @override
  BaseState<XlsViewer> createState() => _XlsViewer();
}

class _XlsViewer extends BaseState<XlsViewer> {

  String fileUrl = '';
  Excel excel = Excel.createExcel();

  @override
  void initState(){
    super.initState();
    fileUrl = (widget as XlsViewer).xlsUrl;

    tryPrntData();
    
    print("FILE URL === $fileUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel Viewer'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetchAndReadExcel(fileUrl),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SingleChildScrollView(
                child: Container()
              );
            }
          },
        ),
      ),
    );
  }

  Future<String> _fetchAndReadExcel(String url) async {
    try {
      // Fetch the XLSX file from the URL
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200)
      {
        // Read the XLSX file
        var bytes = response.bodyBytes;
        excel = Excel.decodeBytes(bytes);
        String excelData = '';

        // Iterate through rows and columns to read data
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            for (var cell in row) {
              // Append cell value to the data string
              excelData += '$cell ';
            }
            // Add a new line after each row
            excelData += '\n';
          }
        }

        // Return the Excel data
        return excelData;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  void castStatefulWidget() {
    widget is XlsViewer;
  }

  Future<void> tryPrntData() async {
    print("PRINT DATA  ==== ${await _fetchAndReadExcel(fileUrl)}");
  }
}