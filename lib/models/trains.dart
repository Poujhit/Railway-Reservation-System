class Train {
  final String arrivaltime;
  final String depaturetime;
  final String destination;
  final bool isWeekdaytrain;
  final bool isWeekendtrain;
  String resetseatsDate;
  final Map<String, dynamic> seatprice;
  final String source;
  final String trainname;
  final String trainno;
  Map<String, dynamic> availableseats;

  Train({
    this.arrivaltime,
    this.availableseats,
    this.depaturetime,
    this.destination,
    this.isWeekdaytrain,
    this.isWeekendtrain,
    this.resetseatsDate,
    this.seatprice,
    this.source,
    this.trainname,
    this.trainno,
  });
}
