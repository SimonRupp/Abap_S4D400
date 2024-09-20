CLASS zcl_08_demo_05 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_demo_05 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  while sy-index < 11.
  out->write( sy-index ).
  ENDWHILE.

  DO 10 times.
  out->write( sy-index ).
  ENDDO.

  Do.
  out->write( sy-index ).
  if sy-index = 10.
  exit.
  endif.
  enddo.

  ENDMETHOD.
ENDCLASS.
