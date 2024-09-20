CLASS zcl_08_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

 DATA number1 TYPE i.
 DATA number2 TYPE i.

 number1 = -2738642.
 number2 = 1245561.

 "DATA result TYPE p LENGTH 4 DECIMALS 2.
 DATA(result) = number1 / number2.
 DATA output TYPE c LENGTH 60.
 output =  |{ number1 } / { number2 } = { result }| .
 out->write( output ).

  ENDMETHOD.
ENDCLASS.
