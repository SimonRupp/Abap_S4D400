CLASS z_es_kracht_aufgabe2_3_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA seatsNeeded TYPE i.
    DATA zeitImVoraus TYPE i.
    DATA depLoc TYPE string.
    DATA arrLoc TYPE string.
    DATA lastminute TYPE /dmo/flight_date.
    DATA outputtable TYPE TABLE OF Z_ES_KRACHT_CDS_Join_Aufgabe3.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS z_es_kracht_aufgabe2_3_2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    zeitimvoraus = 1000.
    seatsneeded = 3.
    deploc = 'DE'.
    arrLoc = 'US'.

    lastminute = sy-datum + zeitimvoraus.

    IF arrloc = ''.
      SELECT *
  FROM Z_ES_KRACHT_CDS_Join_Aufgabe3
  WHERE FlightDate <= @lastminute
  AND ( DepatureCity = @deploc OR AirportFromId = @deploc ) OR AirportFromId = @deploc
INTO TABLE @outputtable.

      out->write( outputtable ).
    ELSE.
      SELECT *
    FROM Z_ES_KRACHT_CDS_Join_Aufgabe3
    WHERE FlightDate <= @lastminute
      AND ( ( AirportFromId = @deploc OR DepatureCity = @deploc ) OR DepartureCountry = @deploc )
      AND ( ( AirportToId = @arrloc OR ArrivalCity = @arrloc ) OR ArrivalCountry = @arrloc )
      AND SeatsAvailable > @seatsneeded
    INTO TABLE @outputtable.

      out->write( outputtable ).

    ENDIF.




  ENDMETHOD.
ENDCLASS.
