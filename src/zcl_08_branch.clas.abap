CLASS ZCL_08_BRANCH DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_08_BRANCH IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Declarations
**************************

    DATA number1 TYPE i.
    DATA number2 TYPE i.

    DATA result TYPE p LENGTH 8 DECIMALS 2.


* Input Values
**************************

    number1 = -8.
    number2 = 0.

* Calculation
**************************

*    DATA(result) = number1 / number2.
DATA op type c LENGTH 1.
 op = '*'.
 data output type c length 34.

CASE op.
WHEN '/'.
try.
result = number1 / number2.
CATCH cx_sy_ZERODIVIDE INTO FINAL(x).
out->write( x ).
ENDTRY.
when '+'.
result  = number1 + number2.
when '-'.
result  = number1 - number2.
when '*'.
result  = number1 * number2.
when OTHERS.
out->write( 'Fehler, invalider Rechenoperator' ).
ENDCASE.



    IF output is INITIAL.
      output = |{ number1 } { op } { number2 } = { result }|.
    out->write( output ).
    ELSE.
    ENDIF.


* Output
**************************



  ENDMETHOD.
ENDCLASS.
