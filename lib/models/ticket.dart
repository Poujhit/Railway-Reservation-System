class Ticket {
  final List passengers;
  final String ticId;
  final int ticketStatus;
  final int totalPrice;
  final String trainno;
  final String date;
  int sno;

  Ticket({
    this.passengers,
    this.ticId,
    this.ticketStatus,
    this.date,
    this.totalPrice,
    this.trainno,
    this.sno,
  });
}
