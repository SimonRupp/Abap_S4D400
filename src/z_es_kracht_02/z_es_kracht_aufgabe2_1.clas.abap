CLASS z_es_kracht_aufgabe2_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA customerId TYPE /dmo/customer_id.
    DATA bookingId TYPE /dmo/booking_id.
    DATA ausgabeId TYPE TABLE OF Z_ES_KRACHT_CDS_Join_Aufgabe1.
    DATA ausgabeName TYPE TABLE OF Z_ES_KRACHT_CDS_Join_Aufgabe1.
    DATA firstname TYPE /dmo/first_name.
    DATA lastname TYPE /dmo/last_name.

    METHODS flugdatenabfrage
      IMPORTING
        iv_customerid TYPE /dmo/customer_id
        iv_bookingid TYPE /dmo/booking_id
        iv_firstname TYPE /dmo/first_name
        iv_lastname TYPE /dmo/last_name
        i_out TYPE REF TO if_oo_adt_classrun_out.

    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS z_es_kracht_aufgabe2_1 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    customerid = '00093'.
    bookingid = '0003'.

    lastname = ''.
    firstname = ''.



    flugdatenabfrage( iv_customerid = customerid
                      iv_bookingid = bookingid
                      iv_firstname = firstname
                      iv_lastname = lastname
                      i_out = out ).

  ENDMETHOD.

  METHOD flugdatenabfrage.
    " Übernahme der übergebenen Parameter
    customerid = iv_customerid.
    bookingid = iv_bookingid.
    firstname = iv_firstname.
    lastname = iv_lastname.

         " String für die Striche definieren
    DATA(lv_striche) = '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.
    DATA(lv_strich_ende) = '""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'.


    " Fehlerabfangung beim Datenbankzugriff
    TRY.
        SELECT FROM Z_ES_KRACHT_CDS_Join_Aufgabe1
          FIELDS *
          WHERE BookingId = @bookingid AND CustomerId = @customerid
          INTO TABLE @ausgabeId.

        SELECT FROM Z_ES_KRACHT_CDS_Join_Aufgabe1
          FIELDS *
          WHERE FirstName = @firstname AND LastName = @lastname
          INTO TABLE @ausgabeName.

      CATCH cx_sy_open_sql_db.
        i_out->write( 'Fehler beim Zugriff auf die Datenbank. Bitte prüfen Sie die Datenbankverbindung.' ).
        RETURN.

    ENDTRY.

  TRY.
      IF ausgabeId IS INITIAL AND ausgabeName IS INITIAL.
        i_out->write( lv_striche ).
        i_out->write( 'Unter den von Ihnen eingegebenen Daten liegen uns leider keine Buchungsdaten vor' ).
        i_out->write( lv_striche ).

      ELSEIF lastname IS INITIAL OR firstname IS INITIAL.
        i_out->write( lv_striche ).
        i_out->write( 'Unter den von Ihnen eingegebenen Daten liegen uns leider keine Buchungsdaten vor' ).
        i_out->write( lv_striche ).

      ELSE.
        IF ausgabeName = ausgabeId.
          i_out->write( lv_striche ).
          i_out->write( |Unter der BuchungsId: { bookingId } und dem Namen { firstname } { lastname } liegen in unserem System folgende Daten vor:| ).
          i_out->write( lv_strich_ende ).
          i_out->write( ausgabeId ).
          i_out->write( lv_strich_ende ).

        ELSEIF ausgabeId IS INITIAL AND ausgabeName IS NOT INITIAL.
          i_out->write( lv_striche ).
          i_out->write( |Unter dem Namen: { firstname } { lastname } liegen uns folgende Daten vor:| ).
          i_out->write( lv_strich_ende ).
          i_out->write( ausgabeName ).
          i_out->write( lv_strich_ende ).

        ELSEIF ausgabeId IS NOT INITIAL AND ausgabeName IS INITIAL.
          i_out->write( |Unter der BuchungsId: { bookingid } liegen uns folgende Daten vor:| ).
          i_out->write( lv_striche ).
          i_out->write( ausgabeId ).
          i_out->write( lv_striche ).

        ELSE.
          i_out->write( lv_striche ).
          i_out->write( 'Wir haben unterschiedliche Einträge zu Ihren Angaben gefunden.' ).
          i_out->write( lv_striche ).
          i_out->write( 'Bitte überprüfen Sie ihre Eingabe und versuchen Sie es gegebenenfalls erneut' ).
          i_out->write( lv_striche ).
          i_out->write( |Ausgabe für die CustomerId: { customerId } und die BookingId: { bookingId }| ).
          i_out->write( lv_strich_ende ).
          i_out->write( ausgabeId ).
          i_out->write( lv_strich_ende ).
          i_out->write( lv_striche ).
          i_out->write( |Ausgabe für den Namen: { firstname } { lastname }| ).
          i_out->write( lv_strich_ende ).
          i_out->write( ausgabeName ).
          i_out->write( lv_strich_ende ).

        ENDIF.
      ENDIF.

    CATCH cx_sy_itab_line_not_found.
      i_out->write( 'Fehler: Es wurde keine entsprechende Zeile in der Tabelle gefunden.' ).

    CATCH cx_sy_no_handler.
      i_out->write( 'Ein unerwarteter Fehler ist aufgetreten.' ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.


