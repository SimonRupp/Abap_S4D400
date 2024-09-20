CLASS zcl_08_demo_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_demo_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "Definition eines lokalen Strukturtypen
  TYPES: begin of ty_flight,
         carrier_id TYPE /dmo/carrier_id,
         conncetion_id TYPE /dmo/connection_id,
         flight_date TYPE /dmo/flight_date,
         flight_price type /dmo/flight_price,
         currency_code TYPE /dmo/currency_code,
         END OF ty_flight.

         "Deklaration einer Struktur(variablen)
         DATA flight TYPE ty_flight.

         "Zugriff auf die Strukturkomponenten
         flight-carrier_id = 'LH'.
         flight-conncetion_id = '0400'.
         "flight-flight_date = sy-datlo.
         flight-flight_date = cl_abap_context_info=>get_system_date(  ).

         "Erweitern und/oder überschreiben

         flight = VALUE #( base flight
         conncetion_id = '0401'
         flight_price = '734.99'
         currency_code = 'EUR' ).

         out->write( flight-flight_date ).


  ENDMETHOD.
ENDCLASS.
