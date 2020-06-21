import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import './coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[10];
  String selectedCrypto = cryptoList[0];
  String cryptoInfo;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem> currencyMenuItems = currenciesList
        .map((currency) => DropdownMenuItem(
              child: Text(currency),
              value: currency,
            ))
        .toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyMenuItems,
      onChanged: (value) {
        if (value != selectedCurrency) {
          setState(() {
            selectedCurrency = value;
            cryptoInfo = null;
            getCryptoInfo();
          });
        }
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> currencyTextItems =
        currenciesList.map((currency) => Text(currency)).toList();

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        if (currenciesList[selectedIndex] != selectedCurrency) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            cryptoInfo = null;
            getCryptoInfo();
          });
        }
      },
      children: currencyTextItems,
    );
  }

  void getCryptoInfo() async {
    dynamic coinData =
        await CoinData().getCoinData(selectedCurrency, selectedCrypto);
    setState(() {
      cryptoInfo = coinData['rate'].toInt().toString();
    });
  }

  @override
  void initState() {
    super.initState();

    getCryptoInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCrypto = ${cryptoInfo ?? '?'} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
