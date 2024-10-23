CLASS z_es_kracht_presetation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_es_kracht_presetation IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Aufgabe 1

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 1 Beispiel 1: Name und IDs sind vorhanden ' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).

    DATA(lo_flight_data) = NEW z_es_kracht_aufgabe2_1( ).  " Erstelle ein Objekt der Klasse z_es_kracht_aufgabe2_1

    TRY.
        " Rufen Sie die Methode numberFlights auf
        lo_flight_data->flugdatenabfrage(
         iv_customerid = '00085'
         iv_bookingid =  '0001'
         iv_firstname = 'Christine'
         iv_lastname = 'Martin'
         i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.

    out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 1 Beispiel 2: Nur Name' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).

    TRY.
        " Rufen Sie die Methode numberFlights auf
        lo_flight_data->flugdatenabfrage(
         iv_customerid = 0
         iv_bookingid =  0
         iv_firstname = 'Kurt'
         iv_lastname = 'Hoffen'
         i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.

    out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 1 Beispiel 3: Nur IDs' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).

    TRY.
        " Rufen Sie die Methode numberFlights auf
        lo_flight_data->flugdatenabfrage(
         iv_customerid = '000594'
         iv_bookingid =  '0001'
         iv_firstname = ''
         iv_lastname = ''
         i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.

    out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 1 Beispiel 4: Falsche Eingaben' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).

    TRY.
        " Rufen Sie die Methode numberFlights auf
        lo_flight_data->flugdatenabfrage(
         iv_customerid = 12
         iv_bookingid =  12
         iv_firstname = '54'
         iv_lastname = '456'
         i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Aufgabe 2

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 2 Beispiel 1' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).
    DATA(lo_auskunft) = NEW z_es_kracht_aufgabe2_2( ).

    TRY.
        lo_auskunft->auskunft(
          iv_connection = '0001'
          iv_carrier = 'SQ'
          iv_date = '20250528'
          i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.

      out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 2 Beispiel 1' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).

        TRY.
        lo_auskunft->auskunft(
          iv_connection = '0001'
          iv_carrier = 'SQ'
          iv_date = '20250528'
          i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Aufgabe 3

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 3' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).

    DATA(lo_lastminute) = NEW z_es_kracht_aufgabe2_3( ).

    TRY.
        " Aufruf der Methode lastminuteOutput und Übergabe der Parameter
        lo_lastminute->lastminuteOutput(
          iv_seatsNeeded = 3
          iv_zeitImVoraus = 1000
          iv_depLoc = 'DE'
          iv_arrLoc = 'US'
          i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Aufgabe 4

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( '*' ).
    out->write( '*' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( 'Aufgabe 4' ).
 out->write( '=============================================================================================================================================================================================================================================' ).
    out->write( '*' ).
    out->write( '*' ).

    DATA(lo_numberflights) = NEW z_es_kracht_aufgabe2_4( ).

    TRY.
        " Aufruf der Methode lastminuteOutput und Übergabe der Parameter
        lo_numberflights->numberflights(
        iv_eingabe = 'US'
        i_out = out ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

      CATCH cx_sy_no_handler.
        out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.


  ENDMETHOD.
ENDCLASS.
