import 'package:get/get.dart';

import '../model/bus_ticket_model.dart';

class BusViewModel extends GetxController{
  int index = 0;
  updateIndex(_){
    index=_;
    update();
  }
  List<BusTicketModel> userTicket =
    [
      BusTicketModel ( from:"Rak", to:"Dubai", date:"2024-05-01", fromDateTime:"12:00", toDateTime:"3:00", price:"50", status: false),
      BusTicketModel ( from:"Sharja", to:"Dubai", date:"2024-04-15", fromDateTime:"5:00", toDateTime:"9:00", price:"50", status: false),
      BusTicketModel ( from:"Rak", to:"Ajman", date:"2024-05-05", fromDateTime:"1:00", toDateTime:"5:00", price:"50", status: false),
    ];
  addTicket(BusTicketModel _){
    userTicket.add(_);
    update();
  }
}