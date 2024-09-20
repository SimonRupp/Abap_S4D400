CLASS zcl_08_demo_04 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_demo_04 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA flight_date TYPE /dmo/flight_date VALUE '20241415'.
    DATA carrier_id  TYPE /dmo/carrier_id VALUE 'MH'.

    "
    "Einfache Verzweigungen
    "


    IF flight_date >= '20240101' AND flight_date < '20250101' OR carrier_id <> 'MH-370'.
      out->write( 'Lellek' ).
      " logsche Operatoren: AND OR NOT
      " Vergleichsoperatoren: <, >, <=, >=, =, <>
    ELSE.
      out->write( 'Alle HUHU' ).
    ENDIF.

    IF flight_date BETWEEN '20140101' AND '20250101'.
      out->write( 'IF 2 ist erfüllt' ).

    ENDIF.

    out->write( cond #( when flight_date BETWEEN '20240101' AND '20250101' then 'COND erfüllt' else 'Cond nicht erfüllt' ) ).


    "
    "Fallunterscheidungen
    "

    carrier_id = '    '.
    IF carrier_id IS INITIAL. " carrier_id = ''.
      out->write( 'IF 3 ist erfüllt' ).
    ENDIF.

    IF carrier_id = 'LH'.
      out->write( 'Lufthansa' ).
    ELSEIF carrier_id = 'MH'.
      out->write( 'Es knallt' ).
    ENDIF.

    CASE carrier_id.
      WHEN 'LH'.
        out->write( 'Lufthansa' ).

      WHEN 'MH'.
        out->write( 'Malasia Airlines' ).
      WHEN OTHERS.
        out->write( carrier_id ).

          ENDCASE.

        out->write( switch #( carrier_id when 'lh' Or 'LH' then 'Lufthansa'
        when 'mh' or 'MH' then 'malaysia' else carrier_id
        ) ).




  ENDMETHOD.
ENDCLASS.
