CLASS zcl_08_demo_10 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_demo_10 IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.
  data flight type /dmo/flight.



  SELECT  Single
  from /dmo/flight
  FIELDS carrier_id, connection_id, flight_date,price,currency_code
  WHERE carrier_id = 'LH'
  into  CORRESPONDING FIELDS OF @flight. "Kopieren namensgleicher Komponetnen.

  ENDMETHOD.
ENDCLASS.
