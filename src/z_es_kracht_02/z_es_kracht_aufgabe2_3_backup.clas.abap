CLASS z_es_kracht_aufgabe2_3_Backup DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA seatsNeeded TYPE i.
    DATA zeitImVoraus TYPE i.
    DATA depLoc TYPE string.
    DATA arrLoc TYPE string.
    DATA lastminute TYPE /dmo/flight_date.
    DATA outputtable TYPE TABLE OF Z_ES_KRACHT_CDS_Join_Aufgabe3.
    DATA whereCondition TYPE string.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS lastminuteOutput
      IMPORTING
        i_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.

CLASS z_es_kracht_aufgabe2_3_backup IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    zeitimvoraus = 1000.
    seatsneeded = 3.
    deploc = 'DE'.
    arrLoc = 'US'.

    lastminuteOutput( out ).

  ENDMETHOD.

  METHOD lastminuteOutput.
    " Striche definieren für die Ausgabe
    DATA(lv_striche) = '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.
    DATA(lv_strich_ende) = '""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'.

    " Berechnung des Last-Minute-Datums
    lastminute = sy-datum + zeitimvoraus.

    TRY.
      " Bedingung für WHERE-Klausel dynamisch aufbauen
      IF arrloc = ''.
        whereCondition = | FlightDate <= @lastminute AND SeatsAvailable > @seatsneeded AND ( DepatureCity = @deploc OR AirportFromId = @deploc ) |.
      ELSE.
        whereCondition = |FlightDate <= @lastminute AND SeatsAvailable > @seatsneeded AND ( ( AirportFromId = @deploc OR DepatureCity = @deploc ) OR DepartureCountry = @deploc ) |.
        whereCondition = | { whereCondition } AND ( ( AirportToId = @arrloc OR ArrivalCity = @arrloc ) OR ArrivalCountry = @arrloc ) |.
      ENDIF.

      " Datenbankabfrage durchführen
      SELECT *
        FROM Z_ES_KRACHT_CDS_Join_Aufgabe3
        WHERE (whereCondition)
        INTO TABLE @outputtable.

      " Ausgabe der gefundenen Daten
      i_out->write( lv_striche ).
      i_out->write( |In den nächsten { zeitimvoraus } Tagen gibt es folgende Last-Minute-Flüge von { deploc } nach { arrLoc }:| ).
      i_out->write( lv_striche ).
      i_out->write( outputtable ).
      i_out->write( lv_strich_ende ).
      i_out->write( lv_strich_ende ).

    CATCH cx_abap_datfm.
      i_out->write( 'Beim Lesen der Daten aus der Datenbank ist ein Fehler aufgetreten.' ).

    CATCH cx_sy_open_sql_db.
      i_out->write( 'Fehler beim Zugriff auf die Datenbank. Bitte prüfen Sie die Verbindung.' ).

    CATCH cx_sy_itab_line_not_found.
      i_out->write( 'Keine Zeilen in der Ergebnistabelle gefunden.' ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.

