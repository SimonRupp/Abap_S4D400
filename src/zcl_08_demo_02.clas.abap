CLASS zcl_08_demo_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_demo_02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA result TYPE p DECIMALS 4 LENGTH 5.

    result = 2 + 5.
    out->write( result ).
    result = 5 - 3.
    out->write( result ).

    result = 5 * 3.
    out->write( result ).
    result = 5 DIV 3.
    out->write( result ).
    result = 5 MOD 3.
    out->write( result ).
    result = 5 ** 3.
    out->write( result ).
    result = 0.
    result = result + 1.




    out->write( result ).



    result = 1150 / 130.
  ENDMETHOD.
ENDCLASS.
