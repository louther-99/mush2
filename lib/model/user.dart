class Users {
  final String id;
  final int batchNumber;
  final double lightLevel;
  final double roomTemp;
  final double humidity;
  final String outcome;
  final DateTime datetime;

  Users({
    required this.id,
    required this.batchNumber,
    required this.lightLevel,
    required this.roomTemp,
    required this.humidity,
    required this.outcome,
    required this.datetime,
  });

  Map<String, dynamic> toJson() => { //Converts object to JSON
    'id': id,
    'batchNumber': batchNumber,
    'lightLevel': lightLevel,
    'roomTemp': roomTemp,
    'humidity': humidity,
    'outcome': outcome,
    'datetime': datetime,
  };

  static Users fromJson (Map<String, dynamic> json) => Users(
    id: json['id'],
    batchNumber: json['batchNumber'],
    lightLevel: json['lightLevel'],
    roomTemp: json['roomTemp'],
    humidity: json['humidity'],
    outcome: json['outcome'],
    datetime: json['datetime'],
  );//Converts object to JSON


}