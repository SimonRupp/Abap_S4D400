CLASS z_es_kracht_aufgabe2_3 DEFINITION
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

    METHODS lastminuteOutput
      IMPORTING
        iv_seatsNeeded TYPE i
        iv_zeitImVoraus TYPE i
        iv_depLoc TYPE string
        iv_arrLoc TYPE string
        i_out TYPE REF TO if_oo_adt_classrun_out.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS z_es_kracht_aufgabe2_3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    " Werte setzen
    seatsNeeded = 3.
    zeitImVoraus = 1000.
    depLoc = 'DE'.
    arrLoc = 'SFO'.

    " Aufruf der Methode lastminuteOutput
    lastminuteOutput(
      iv_seatsNeeded = seatsNeeded
      iv_zeitImVoraus = zeitImVoraus
      iv_depLoc = depLoc
      iv_arrLoc = arrLoc
      i_out = out ).
  ENDMETHOD.

  METHOD lastminuteOutput.

    " Parameter den lokalen Variablen zuweisen
    seatsNeeded = iv_seatsNeeded.
    zeitImVoraus = iv_zeitImVoraus.
    depLoc = iv_depLoc.
    arrLoc = iv_arrLoc.

    " String für die Striche definieren
    DATA(lv_striche) = '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.
    DATA(lv_strich_ende) = '""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'.

    " Berechnung des Last-Minute-Datums
    lastminute = sy-datum + zeitImVoraus.

    TRY.
      " Bedingung für WHERE-Klausel dynamisch aufbauen
      IF arrLoc = ''.
        whereCondition = | FlightDate <= @lastminute AND SeatsAvailable > @seatsNeeded AND ( DepatureCity = @depLoc OR AirportFromId = @depLoc ) |.
      ELSE.
        whereCondition = |FlightDate <= @lastminute AND SeatsAvailable > @seatsNeeded AND ( ( AirportFromId = @depLoc OR DepatureCity = @depLoc ) OR DepartureCountry = @depLoc ) |.
        whereCondition = | { whereCondition } AND ( ( AirportToId = @arrLoc OR ArrivalCity = @arrLoc ) OR ArrivalCountry = @arrLoc ) |.
      ENDIF.

      " Datenbankabfrage durchführen
      SELECT *
        FROM Z_ES_KRACHT_CDS_Join_Aufgabe3
        WHERE (whereCondition)
        INTO TABLE @outputtable.

      " Ausgabe der gefundenen Daten
      i_out->write( lv_striche ).
      i_out->write( |In den nächsten { zeitImVoraus } Tagen gibt es folgende Last-Minute-Flüge von { depLoc } nach { arrLoc }:| ).
          i_out->write( lv_strich_ende ).
      i_out->write( outputtable ).
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

