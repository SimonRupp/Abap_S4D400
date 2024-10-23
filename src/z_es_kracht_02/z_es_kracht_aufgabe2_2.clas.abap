CLASS z_es_kracht_aufgabe2_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA connection TYPE /dmo/connection_id.
    DATA carrier TYPE /dmo/carrier_id.
    DATA date TYPE /dmo/flight_date.
    DATA auskunftTabelle TYPE TABLE OF zesflight.

    METHODS auskunft
      IMPORTING
        iv_connection TYPE /dmo/connection_id
        iv_carrier    TYPE /dmo/carrier_id
        iv_date       TYPE /dmo/flight_date
        i_out         TYPE REF TO if_oo_adt_classrun_out.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS z_es_kracht_aufgabe2_2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    connection = '0001'.
    carrier = 'SQ'.
    date = '20250528'.

    " Aufruf der Methode auskunft mit übergebenen Parametern
    auskunft( iv_connection = connection
              iv_carrier = carrier
              iv_date = date
              i_out = out ).
  ENDMETHOD.

  METHOD auskunft.

    " Übergabe der Parameter an die lokalen Variablen
    connection = iv_connection.
    carrier = iv_carrier.
    date = iv_date.

    " String für die Striche definieren
    DATA(lv_striche) = '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.
    DATA(lv_strich_ende) = '""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'.

    TRY.
        " Datenbankabfrage
        SELECT FROM zesflight
          FIELDS *
          WHERE connection_id = @connection AND carrier_id = @carrier AND flight_date = @date
          INTO TABLE @auskunftTabelle.

      CATCH cx_sy_open_sql_db.
        i_out->write( lv_striche ).
        i_out->write( 'Fehler beim Zugriff auf die Datenbank. Bitte prüfen Sie die Verbindung.' ).
        i_out->write( lv_striche ).

        RETURN.

      CATCH cx_sy_itab_line_not_found.
        i_out->write( lv_striche ).
        i_out->write( 'Fehler: Keine Einträge in der Datenbanktabelle gefunden.' ).
        i_out->write( lv_striche ).

        RETURN.

    ENDTRY.

    IF auskunftTabelle IS INITIAL.
      " Keine Daten gefunden
      i_out->write( lv_striche ).
      i_out->write( 'Unter den von Ihnen angegebenen Daten, konnten wir leider keine Einträge finden' ).
      i_out->write( lv_striche ).

    ELSE.
      " Daten gefunden und ausgeben
      TRY.
          i_out->write( lv_striche ).
          i_out->write( |Unter den Daten: | ).
          i_out->write( lv_striche ).
          i_out->write( |Connection-ID: { connection } | ).
          i_out->write( |Carrier-ID:  { carrier } | ).
          i_out->write( |Datum: { date } | ).
          i_out->write( lv_striche ).
          i_out->write( |liegen in unserem System folgende Daten vor:| ).
          i_out->write( lv_strich_ende ).
          i_out->write( auskunftTabelle ).
          i_out->write( lv_strich_ende ).

        CATCH cx_sy_itab_line_not_found.
          i_out->write( 'Fehler: Keine Zeilen in der Ausgabetabelle gefunden.' ).

        CATCH cx_sy_no_handler.
          i_out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

      ENDTRY.

    ENDIF.

  ENDMETHOD.

ENDCLASS.


