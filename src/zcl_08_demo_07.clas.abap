CLASS zcl_08_demo_07 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_08_demo_07 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA carrier_id    TYPE /dmo/carrier_id.
    carrier_id = 'LH'.
    DATA flight_price  TYPE /dmo/flight_price.

    DATA flight_prices TYPE TABLE OF /dmo/flight_price.

    data flights type table of /dmo/flight.

    " SELECT <Spalte 1>, <Spalte 2>,...
    " FROM <Datenbankqulle>
    " WHERE <Bedingung>

    " Lesender Zugriff auf einen Datensatz
    SELECT SINGLE FROM /dmo/flight
      FIELDS price
      WHERE carrier_id = 'LH' AND connection_id = '0400' AND flight_date = '20240707'
      INTO @DATA(flight_price_1). " INT0 @DATE(flight_price).

    out->write( flight_price ).
    SELECT Single from /dmo/flight
    Fields *
    WHERE carrier_id = 'LH' AND connection_id = '0400' AND flight_date = '20240707'
    INTO @data(flight).

    out->write( flight ).


    SELECT FROM /dmo/flight
      FIELDS price
      WHERE carrier_id = @carrier_id
      INTO TABLE @flight_prices.

    out->write( flight_prices ).


     SELECT FROM /dmo/flight
      FIELDS *
      WHERE carrier_id = @carrier_id
      INTO TABLE @flights.

  ENDMETHOD.
ENDCLASS.
