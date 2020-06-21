import 'package:flutter_dotenv/flutter_dotenv.dart';

import './networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String COIN_API_IO_URL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinData(String currency, String crypto) async {
    currency ??= currenciesList[10];
    crypto ??= cryptoList[0];

    String requestUrl =
        '$COIN_API_IO_URL/$crypto/$currency?apikey=${DotEnv().env['api_key']}';
    NetworkHelper networkHelper = NetworkHelper(requestUrl);

    return await networkHelper.getData();
  }
}
