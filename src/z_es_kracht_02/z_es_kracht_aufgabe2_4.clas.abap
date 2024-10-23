CLASS z_es_kracht_aufgabe2_4 DEFINITION
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
        result         TYPE i.

       METHODS numberFlights
      IMPORTING
        iv_eingabe type string
        i_out TYPE REF TO if_oo_adt_classrun_out.                               " Anzahl der gefilterten Einträge

    INTERFACES if_oo_adt_classrun .                                     " Interface für ADT-Klassenlauf


ENDCLASS.


CLASS z_es_kracht_aufgabe2_4 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    eingabe = 'fchfc'. " Beispielhafte Eingabe eines Landes- oder Flughafencodes

    numberFlights( iv_eingabe = eingabe
    i_out = out ).


  ENDMETHOD.

  METHOD numberFlights.

  eingabe = iv_eingabe.

     DATA(lv_striche) = '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.
    DATA(lv_strich_ende) = '""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'.


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
              WHERE AirportToId = @iv_eingabe
              INTO @flughafenname.

            " Zählen der Abflüge und Ankünfte
            dep = lines( tabelleabfuege ).
            arr = lines( tabelleankuefte ).

            " Ausgabe der Ergebnisse

            i_out->write( 'Ankünfte:' ).
          i_out->write( lv_strich_ende ).
            i_out->write( tabelleankuefte ).
      i_out->write( lv_strich_ende ).
            i_out->write( 'Abflüge:' ).
          i_out->write( lv_strich_ende ).
            i_out->write( tabelleabfuege ).
      i_out->write( lv_strich_ende ).

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

      i_out->write( lv_striche ).
            i_out->write( 'Abflüge:' ).
          i_out->write( lv_strich_ende ).
            i_out->write( ausgabetabelle ).
      i_out->write( lv_strich_ende ).

            CALL METHOD filter
              EXPORTING
                tabelleeingabe = tabelle
                compare_field  = 'AirportFromId'  " Filterung nach Abflügen
              IMPORTING
                tabelleausgabe = ausgabetabelle
                result         = arr.

            " Ausgabe der Ergebnisse für das ausgewählte Land
      i_out->write( lv_striche ).
            i_out->write( 'Ankünfte:' ).
          i_out->write( lv_strich_ende ).
            i_out->write( ausgabetabelle ).
      i_out->write( lv_strich_ende ).
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
      i_out->write( lv_striche ).
            i_out->write( 'Abflüge:' ).
          i_out->write( lv_strich_ende ).
            i_out->write( ausgabetabelle ).
      i_out->write( lv_strich_ende ).
            " Anzahl der Ankünfte speichern

            CALL METHOD filter
              EXPORTING
                tabelleeingabe = tabelle
                compare_field  = 'AirportFromId'    " Filterung nach Abflügen
              IMPORTING
                tabelleausgabe = ausgabetabelle   " Gefilterte Tabelle für Abflüge
                result         = arr.               " Anzahl der Abflüge speichern

      i_out->write( lv_striche ).
            i_out->write( 'Ankünfte:' ).
          i_out->write( lv_strich_ende ).
            i_out->write( ausgabetabelle ).
      i_out->write( lv_strich_ende ).
            " Ausgabe der Ergebnisse für die ausgewählte Stadt
            i_out->write( | In der von Ihnen gewählten Stadt: { eingabe } gab es: { dep } Abflüge und { arr } Ankünfte| ).
      i_out->write( lv_striche ).


        ENDCASE.  " Ende des CASE-Blocks

      CATCH BEFORE UNWIND cx_abap_datfm_format_unknown.
        " Fehlerbehandlung, falls ein Formatierungsfehler auftritt
      i_out->write( lv_striche ).
        i_out->write( 'Beim Abrufen der Daten ist es zu einem Fehler gekommen' ).
      i_out->write( lv_striche ).
        i_out->write( 'Bitte überprüfen Sie Ihre Eingabe und versuchen Sie es erneut' ).
      i_out->write( lv_striche ).


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



