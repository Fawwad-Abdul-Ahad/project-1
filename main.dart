import 'dart:io';

void main() {
  List<List<dynamic>> Seats = [
    [1, 4, true],
    [2, 6, true],
    [3, 4, true],
    [4, 6, true],
    [5, 4, true],
    [6, 6, true],
  ];
  Map<int, Map<String, dynamic>> reservationDetails = {};
  print("************ Welcome to the Hotel Reservation System ************");
  int tableNumber;
  String date;
  String time;
  String guests;

  while (true) {
    print("1. View Available Tables");
    print("2. Making Reservation");
    print("3. Viewing Reservations");
    print("4. Cancelling Reservaions");
    print("5. Updating Reservations");
    print("6. Exit the program");
    print("Choose Options \n");

    int choice = int.parse(stdin.readLineSync()!);
    if (choice == 1) {
      viewAvailableTables(Seats);
    } else if (choice == 2) {
      print("Enter a table number");
      tableNumber = int.parse(stdin.readLineSync()!);

      print("Enter a date");
      date = stdin.readLineSync()!;

      print("Enter time");
      time = stdin.readLineSync()!;

      print("Enter number of guests");
      guests = stdin.readLineSync()!;

      makingReservation(
          tableNumber, date, time, guests, Seats, reservationDetails);
    } else if (choice == 3) {
      viewingReservation(reservationDetails);
    } else if (choice == 4) {
      print("Enter the reserve Id you want to remove");
      int reservIDbyUser = int.parse(stdin.readLineSync()!);

      // print("Enter the table number");
      // int tableNumber = int.parse(stdin.readLineSync()!);
      reservationCancel(reservIDbyUser, reservationDetails, Seats);
    } else if (choice == 5) {
      print("Enter the reservation ID");
      int reservationID = int.parse(stdin.readLineSync()!);

      print("Enter the table number ");
      int tableNumber = int.parse(stdin.readLineSync()!);

      print("Enter new date ");
      String date = stdin.readLineSync()!;

      print("Enter new time ");
      String time = stdin.readLineSync()!;

      print("Enter the New number of guests");
      String guests = stdin.readLineSync()!;

      UpdatingReservation(
          reservationID, tableNumber, date, time, guests, reservationDetails);
    } else if (choice == 6) {
      exit(0);
    }
  }
}

viewAvailableTables(List<List<dynamic>> seats) {
  for (int i = 0; i < seats.length; i++) {
    if (seats[i][2] == true) {
      print("table number ${i + 1} with capacity 0f ${seats[i][1]} guests \n");
    }
  }
}

makingReservation(
    int tableNumber,
    String date,
    String time,
    String guests,
    List<List<dynamic>> tables,
    Map<int, Map<String, dynamic>> reservationDetails) {
  bool istableAvailable = false;
  int reservID = -1;
  for (int i = 0; i < tables.length; i++) {
    if (tables[i][0] == tableNumber && tables[i][2] == true) {
      istableAvailable = true;
      reservID = i;
      break;
    }
  }

  if (istableAvailable) {
    tables[reservID][2] = false;

    int reservationID = reservationDetails.length + 1;

    reservationDetails[reservationID] = {
      "table Number": tableNumber,
      "Date": date,
      "time": time,
      "guests": guests,
    };

    print("Reservation Successfull, Your reservation id is $reservationID");
  } else {
    print("Sorry table number $tableNumber is not available");
  }
}

viewingReservation(Map<int, Map<String, dynamic>> reservationDetails) {
  if (reservationDetails.isEmpty == true) {
    print("No reservation found");
  }

  reservationDetails.forEach((reservationsID, reservationAddress) {
    print("Your reservation ID is ${reservationsID}");
    print("Your table number: ${reservationAddress["table Number"]}");
    print("Date: ${reservationAddress['Date']}");
    print("Time: ${reservationAddress['time']}");
    print("Number of guests: ${reservationAddress['guests']}\n");
  });
}

reservationCancel(int reserveIdbyUser,
    Map<int, Map<String, dynamic>> ReservationMap, List<List<dynamic>> seats) {
  List<int> removeId = [];

  bool found = false;
  ReservationMap.forEach((reserveID, reservationAddress) {
    if (reserveID == reserveIdbyUser) {
      print("Reservation with ID : $reserveIdbyUser found and cancel........");
      removeId.add(reserveIdbyUser);
      found = true;
    }
  });
  for (int key in removeId) {
    ReservationMap.remove(key);
  }

  if (found != true) {
    print("Reservation with ID : $reserveIdbyUser is not present");
  }
  for (int i = 0; i < seats.length; i++) {
    if (seats[i][2] == false) {
      seats[i][2] = true;
      break;
    }
  }
}

UpdatingReservation(
    int reservationID,
    int TableNumber,
    String Date,
    String Time,
    String Guests,
    Map<int, Map<String, dynamic>> reservationDetails) {
  reservationDetails.forEach((id, details) {
    if (reservationID == id) {
      print("Yes it is found");
      print("The old date is ${details["Date"]}");
      print("The old time is ${details["time"]}");
      print("The old number of guests is ${details["guests"]}\n");

      reservationDetails[reservationID] = {
        "table Number": TableNumber,
        "Date": Date,
        "time": Time,
        "guests": Guests,
      };
    } else {
      print("The reservation id ${reservationID} is not found /\n");
    }
  });
}
