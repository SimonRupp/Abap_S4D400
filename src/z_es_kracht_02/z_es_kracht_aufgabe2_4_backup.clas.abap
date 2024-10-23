*CLASS z_es_kracht_aufgabe2_4_backup DEFINITION
*  PUBLIC
*  FINAL
*  CREATE PUBLIC.
*
*  PUBLIC SECTION.
*    DATA eingabe         TYPE string.
*    DATA tabelleabfuege  TYPE TABLE OF Z_ES_KRACHT_CDS_Join.
*    DATA tabelleankuefte TYPE TABLE OF Z_ES_KRACHT_CDS_Join.
*    DATA flughafenname   TYPE /dmo/airport_name.
*    DATA dep             TYPE i.
*    DATA arr             TYPE i.
*    DATA tabelle         TYPE TABLE OF Z_ES_KRACHT_CDS_Join_Country.
*
*    INTERFACES if_oo_adt_classrun .
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*ENDCLASS.
*
*
*
*CLASS z_es_kracht_aufgabe2_4_backup IMPLEMENTATION.
*  METHOD if_oo_adt_classrun~main.
*
*    eingabe = 'US'.
*    FINAL(lv_length) = strlen( eingabe ).
*
*    TRY.
*
*        CASE lv_length.
*          WHEN 3.
*            SELECT
*              FROM Z_ES_KRACHT_CDS_Join_Airport( airport = @eingabe )
*              FIELDS *
*              WHERE AirportFromId = @eingabe
*              INTO TABLE @tabelleabfuege.
*
*            SELECT
*              FROM Z_ES_KRACHT_CDS_Join_Airport( airport = @eingabe )
*              FIELDS *
*              WHERE AirportToId = @eingabe
*              INTO TABLE @tabelleankuefte.
*
*            SELECT SINGLE
*              FROM Z_ES_KRACHT_CDS_Join_Airport( airport = @eingabe )
*              FIELDS Name
*              WHERE AirportToId = @eingabe
*              INTO @flughafenname.
*
*            dep = lines( tabelleabfuege ).
*
*            arr = lines( tabelleankuefte ).
*
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*
*            out->write( 'Ankünfte' ).
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*
*            out->write( tabelleankuefte ).
*            out->write( 'Abflüge:' ).
*
*            out->write( tabelleabfuege ).
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*
*            out->write(
*                |An dem von Ihnen ausgewählten Flughafen: { flughafenname } gab es: { dep } Abflüge und { arr } Ankünfte| ).
*
*          WHEN 2.
*            SELECT
*              FROM Z_ES_KRACHT_CDS_Join_Country( country_name = @eingabe )
*              FIELDS *
*              INTO TABLE @tabelle.
*
*            LOOP AT tabelle INTO FINAL(ls_temp).
*              IF ls_temp-AirportFromId = ls_temp-AirportId.
*                APPEND ls_temp TO tabelleabfuege.
*              ENDIF.
*            ENDLOOP.
*
*            dep = lines( tabelleabfuege ).
*
*            LOOP AT tabelle INTO FINAL(ls_temp2).
*              IF ls_temp2-AirportToId = ls_temp2-AirportId.
*                APPEND ls_temp2 TO tabelleankuefte.
*              ENDIF.
*            ENDLOOP.
*
*            arr = lines( tabelleankuefte ).
*
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*
*            out->write( 'Ankünfte:' ).
*            out->write( tabelleankuefte ).
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*
*            out->write( 'Abflüge:' ).
*            out->write( tabelleabfuege ).
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*
*            out->write( | In dem von Ihnen gewählten Land: { eingabe } gab es: { dep } Abflüge und { arr } Ankünfte| ).
*
*          WHEN OTHERS.
*
*            SELECT
*              FROM Z_ES_KRACHT_CDS_Join_City( city_name = @eingabe )
*              FIELDS *
*              INTO TABLE @tabelle.
*
*            LOOP AT tabelle INTO DATA(ls_temp3).
*    IF ls_temp3-AirportFromId = ls_temp3-AirportId.
*      APPEND ls_temp3 TO tabelleabfuege.
*    ENDIF.
*  ENDLOOP.
*
*            dep = lines( tabelleabfuege ).
*
*            LOOP AT tabelle INTO FINAL(ls_temp4).
*              IF ls_temp4-AirportToId = ls_temp4-AirportId.
*                APPEND ls_temp4 TO tabelleankuefte.
*              ENDIF.
*            ENDLOOP.
*
*            arr = lines( tabelleankuefte ).
*
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*            out->write( 'Ankünfte:' ).
*            out->write( tabelleankuefte ).
*
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*            out->write( 'Abflüge:' ).
*
*            out->write( tabelleabfuege ).
*            out->write(
*                '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
*
*            out->write( | In der von Ihnen gewählten Stadt: { eingabe } gab es: { dep } Abflüge und { arr } Ankünfte| ).
*
*        ENDCASE.
*
*
*      CATCH BEFORE UNWIND cx_abap_datfm_format_unknown.
*    ENDTRY.
*  ENDMETHOD.
*  ENDCLASS.
CLASS z_es_kracht_aufgabe2_4_backup DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA eingabe         TYPE string.                                   " User-Input, z.B. ein Flughafen, Land oder Stadt
    DATA tabelleabfuege  TYPE TABLE OF Z_ES_KRACHT_CDS_Join.            " Tabelle für die gefilterten Abflüge
    DATA tabelleankuefte TYPE TABLE OF Z_ES_KRACHT_CDS_Join.            " Tabelle für die gefilterten Ankünfte
    DATA ausgabeTabelle  TYPE TABLE OF Z_ES_KRACHT_CDS_Join.
    DATA flughafenname   TYPE /dmo/airport_name.                        " Name des ausgewählten Flughafens
    DATA dep             TYPE i.                                        " Anzahl der Abflüge
    DATA arr             TYPE i.                                        " Anzahl der Ankünfte
    DATA tabelle         TYPE TABLE OF Z_ES_KRACHT_CDS_Join.            " Zwischentabelle für nicht vollständig gefilterte Daten

    METHODS filter
      IMPORTING
        tabelleEingabe TYPE STANDARD TABLE                         " Die zu filternde Tabelle
        compare_field  TYPE string          " Name des Feldes für den Vergleich, z.B. 'AirportToId'
      EXPORTING
        tabelleAusgabe TYPE STANDARD TABLE  " Gefilterte Tabelle
        result         TYPE i.                                      " Anzahl der gefilterten Einträge

    INTERFACES if_oo_adt_classrun .                                     " Interface für ADT-Klassenlauf
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS numberFlights
      IMPORTING
        i_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.


CLASS z_es_kracht_aufgabe2_4_backup IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    eingabe = 'US'. " Beispielhafte Eingabe eines Landes- oder Flughafencodes

    numberFlights( out ).

  ENDMETHOD.

  METHOD numberFlights.

    FINAL(lv_length) = strlen( eingabe ).  " Bestimmung der Länge der Eingabe

    TRY.

        " Logik basierend auf der Länge der Eingabe (3 = Flughafen, 2 = Land, Sonstiges = Stadt)
        CASE lv_length.
          WHEN 3.  " Wenn die Eingabe ein dreistelliger Code (z.B. IATA-Flughafencode) ist
            " Selektion der Abflüge von diesem Flughafen
            SELECT
              FROM Z_ES_KRACHT_CDS_Join_Airport( airport = @eingabe )
              FIELDS *
              WHERE AirportFromId = @eingabe
              INTO TABLE @tabelleabfuege.

            " Selektion der Ankünfte an diesem Flughafen
            SELECT
              FROM Z_ES_KRACHT_CDS_Join_Airport( airport = @eingabe )
              FIELDS *
              WHERE AirportToId = @eingabe
              INTO TABLE @tabelleankuefte.

            " Selektion des Flughafen-Namens basierend auf der Eingabe
            SELECT SINGLE
              FROM Z_ES_KRACHT_CDS_Join_Airport( airport = @eingabe )
              FIELDS Name
              WHERE AirportToId = @eingabe
              INTO @flughafenname.

            " Zählen der Abflüge und Ankünfte
            dep = lines( tabelleabfuege ).
            arr = lines( tabelleankuefte ).

            " Ausgabe der Ergebnisse

            i_out->write( 'Ankünfte:' ).
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( tabelleankuefte ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( 'Abflüge:' ).
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( tabelleabfuege ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).

            " Ausgabe der Anzahl der Abflüge und Ankünfte sowie des Flughafennamens
            i_out->write(
                |An dem von Ihnen ausgewählten Flughafen: { flughafenname } gab es: { dep } Abflüge und { arr } Ankünfte| ).

          WHEN 2.  " Wenn die Eingabe ein zweistelliger Ländercode ist
            " Selektion aller Flughäfen in diesem Land
            SELECT
              FROM Z_ES_KRACHT_CDS_Join_Country( country_name = @eingabe )
              FIELDS *
              INTO TABLE @tabelle.

            " Filterung der Abflüge und Ankünfte mit Hilfe der Methode `filter`
            CALL METHOD filter
              EXPORTING
                tabelleeingabe = tabelle
                compare_field  = 'AirportToId'  " Filterung nach Ankünften
              IMPORTING
                tabelleausgabe = ausgabetabelle
                result         = dep.

            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( 'Abflüge:' ).
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( ausgabetabelle ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).

            CALL METHOD filter
              EXPORTING
                tabelleeingabe = tabelle
                compare_field  = 'AirportFromId'  " Filterung nach Abflügen
              IMPORTING
                tabelleausgabe = ausgabetabelle
                result         = arr.

            " Ausgabe der Ergebnisse für das ausgewählte Land
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( 'Ankünfte:' ).
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( ausgabetabelle ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( | In dem von Ihnen gewählten Land: { eingabe } gab es: { dep } Abflüge und { arr } Ankünfte| ).

          WHEN OTHERS.  " Wenn die Eingabe eine Stadt ist
            " Selektion aller Flughäfen in der Stadt
            SELECT
              FROM Z_ES_KRACHT_CDS_Join_City( city_name = @eingabe )
              FIELDS *
              INTO TABLE @tabelle.

            " Filterung der Abflüge und Ankünfte
            CALL METHOD filter
              EXPORTING
                tabelleeingabe = tabelle
                compare_field  = 'AirportToId'    " Filterung nach Ankünften
              IMPORTING
                tabelleausgabe = ausgabetabelle   " Gefilterte Tabelle für Ankünfte
                result         = dep.
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( 'Abflüge:' ).
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( ausgabetabelle ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            " Anzahl der Ankünfte speichern

            CALL METHOD filter
              EXPORTING
                tabelleeingabe = tabelle
                compare_field  = 'AirportFromId'    " Filterung nach Abflügen
              IMPORTING
                tabelleausgabe = ausgabetabelle   " Gefilterte Tabelle für Abflüge
                result         = arr.               " Anzahl der Abflüge speichern

            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( 'Ankünfte:' ).
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
            i_out->write( ausgabetabelle ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            i_out->write( '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' ).
            " Ausgabe der Ergebnisse für die ausgewählte Stadt
            i_out->write( | In der von Ihnen gewählten Stadt: { eingabe } gab es: { dep } Abflüge und { arr } Ankünfte| ).
            i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).


        ENDCASE.  " Ende des CASE-Blocks

      CATCH BEFORE UNWIND cx_abap_datfm_format_unknown.
        " Fehlerbehandlung, falls ein Formatierungsfehler auftritt
        i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
        i_out->write( 'Beim Abrufen der Daten ist es zu einem Fehler gekommen' ).
        i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).
        i_out->write( 'Bitte überprüfen Sie Ihre Eingabe und versuchen Sie es erneut' ).
        i_out->write( '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' ).


    ENDTRY.

  ENDMETHOD.




  METHOD filter.

    " Leere die Ziel-Tabelle für eine saubere Filterung
    CLEAR ausgabetabelle.

    " Durchlaufe die zu filternde Tabelle und prüfe jeden Eintrag
    LOOP AT tabelle INTO FINAL(ls_temp).
      " Dynamische Zuweisung des Vergleichsfelds
      FIELD-SYMBOLS: <fs_compare> TYPE any.
      ASSIGN COMPONENT compare_field OF STRUCTURE ls_temp TO <fs_compare>.

      " Überprüfen, ob der Wert des Vergleichsfelds mit der AirportId übereinstimmt
      IF sy-subrc = 0 AND <fs_compare> = ls_temp-AirportId.
        " Wenn es eine Übereinstimmung gibt, füge den Eintrag zur gefilterten Tabelle hinzu
        APPEND ls_temp TO ausgabetabelle.
      ENDIF.
    ENDLOOP.

    " Speichere die Anzahl der gefilterten Einträge in der Ergebnis-Variable
    result = lines( ausgabetabelle ).

  ENDMETHOD.
ENDCLASS.



