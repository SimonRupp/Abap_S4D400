CLASS zcl_08_demo_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_demo_06 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Deklaration Liste

    DATA numbers TYPE TABLE OF i.

    " Befüllen der Liste
    numbers = VALUE #( ( 6 ) ( 7 ) (  8 ) ).

    APPEND 42 TO numbers.
    APPEND -3 TO numbers.
    APPEND -7 TO numbers.
    APPEND 42 TO numbers.
    APPEND 12 TO numbers.
    APPEND 9 TO numbers.

    " Lesen von Datensätzen
    TRY.
        out->write( |Die gewählte Nummer ist:{ numbers[ 0 ] }| ).
      CATCH cx_sy_itab_line_not_found INTO FINAL(x).
        out->write( 'es ist ein fehler aufgetreten' ).
        out->write( x->get_text( )  ).
    ENDTRY.

    IF line_exists( numbers[ 5 ] ).
    ENDIF.

    " ausgabe

    out->write( numbers ).
    out->write( |Länge der Liste:  { lines( numbers ) } | ).
  ENDMETHOD.
ENDCLASS.
