class Train {
  final String arrivaltime;
  final String depaturetime;
  final String destination;

  final Map<String, dynamic> seatprice;
  final String source;
  final String trainname;
  final String trainno;

  Train({
    this.arrivaltime,
    this.depaturetime,
    this.destination,
    this.seatprice,
    this.source,
    this.trainname,
    this.trainno,
  });
}

class TrainDetails {
  int availableAcSeats;
  int availableNorSeats;
  int availableSleeperSeats;
  int bookedSleeperSeats;
  int bookedAcSeats;
  int bookedNorSeats;

  String date;
  TrainDetails({
    this.availableAcSeats,
    this.availableNorSeats,
    this.availableSleeperSeats,
    this.bookedAcSeats,
    this.bookedNorSeats,
    this.bookedSleeperSeats,
    this.date,
  });
}
