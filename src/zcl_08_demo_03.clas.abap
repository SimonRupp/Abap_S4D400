CLASS zcl_08_demo_03 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
ENDCLASS.


CLASS zcl_08_demo_03 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA result TYPE string.
    DATA word1  TYPE string VALUE 'Hello'.
    DATA word2  TYPE string VALUE 'World'.
    DATA date TYPE d VALUE '20031911'.

    result &&= word1.

    out->write( |{ word1 } { word2 }| ).

    out->write( |Datum: { date DATE = USER } | ).
  ENDMETHOD.
ENDCLASS.
