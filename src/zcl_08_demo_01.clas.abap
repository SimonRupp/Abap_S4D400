CLASS zcl_08_demo_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_08_demo_01 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TYPES ty_first_name TYPE c LENGTH 20.
    TYPES ty_iuser      TYPE n LENGTH 6.             " Bsp. '749949'
    TYPES ty_birth_date TYPE d.                      " Bsp: '20031119'
    TYPES ty_birth_time TYPE t.                      " Bsp: '054943'
    TYPES ty_number     TYPE i.                      " -476
    TYPES ty_kommazahl  TYPE p LENGTH 16 DECIMALS 2. " Bsp: '5435345.34'
    TYPES ty_error_flag TYPE c LENGTH 1.             " Bsp. 'X'

    DATA first_name TYPE c LENGTH 10.
    DATA last_name TYPE ty_first_name.
    DATA birth_city TYPE /dmo/city VALUE 'Berlin'.

    "out->write( first_name  last_name).

        out->write( birth_city ).



    first_name = 'Karbonat'.
    last_name = ' Erol'.

    DATA iuser TYPE ty_iuser VALUE '749949'.
    DATA(birth_date) = '20031119'.

    out->write( first_name ).
    out->write( last_name ).
    out->write( iuser ).

    Clear iuser.
    out->write( iuser ).


    CONSTANTS pi TYPE p LENGTH 2 DECIMALS 2 VALUE '3.14'.

    out->write( pi ).


  ENDMETHOD.
ENDCLASS.
