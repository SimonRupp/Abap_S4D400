CLASS zcl_08_demo_11 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_demo_11 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "Deklaration interner Tabellen
  DATA flights TYPE z00_flights. "Type <TABELLENTYP>
  data flights2 type table of z00_flight. "TYPE TABLE OF <strukturtyp>#
  data flights3 type  table of /dmo/flight.
    data flights4 type z00_flights.



  DATA flight type z00_flight.

  flight-carrier_id = 'SEX'.
  flight-connection_id = '6969'.
  flight-flight_date = sy-datlo + 60.

  "Einfügen von Datensätzen
  flights = VALUE #(
    ( carrier_id = 'LH' )
    (  connection_id = '0400' )
    ( flight_date = sy-datlo  )
    ( flight ) ( flight_price = '777.99' currency_code = 'EUR' carrier_id = 'AA' )  ).

    "Hinzufügen von Datensätzen
    flight-flight_date -= 30.
    APPEND flight to flights.
    flight-flight_date -= 90.
    flights = VALUE #(  Base flights ( flight ) ).

    out->write( flights ).


    "Kopieren interner Tabellen
    flights2 = flights. " flights 2 ist identisch von den spalten daher kann man sie gleich setzen

    flights3 = corresponding #( flights ). " flights 3 ist nicht idnetisch von den spalten deshalb  corresponding
    flights4 = value #( for f in flights ( f ) ).

    "Lesen von Datensätzen
    flight = flights[ 3 ]. "per index
    flight = flights[ carrier_id = 'LH' connection_id = ' 0401' ]. " per Komponete "gibt den ersten Wert den er findet zurückc

    loop at flights into flight where connection_id > '399'.

    out->write( flight ).
    ENDLOOP.

    "Ändern von Datensätzen
    flights[ 3 ]-flight_price = '500'.
    flights[ carrier_id = 'LH'
              connection_id = '0401' ]-flight_price = '199.95'.

        "Sortieren interner Tabllen
    SORT flights2 by carrier_id DESCENDING connection_id ASCENDING flight_date DESCENDING.

    "Löschen von datensätzen
    DELETE flights index 2.
    delete flights where carrier_id is INITIAL.
    out->write( flights2 ).



    "Sortieren interner Tabllen








  ENDMETHOD.
ENDCLASS.
