CLASS lcl_vehicle DEFINITION.

  PUBLIC SECTION.
    DATA make         TYPE string.
    DATA model        TYPE string.
    DATA speed_in_kmh TYPE i.

    CLASS-DATA number_of_vehicles TYPE i.

    " public void accelerate(int value) {speedInKmh += value;}
    METHODS accelerate
      IMPORTING !value TYPE i.

    METHODS break
      IMPORTING !value TYPE i
      RAISING
        cx_abap_invalid_value.

    " public String toString(){return make + ", " + model + ", " + speedInKmh}
    METHODS to_string
    RETURning Value(returning) type string.
ENDCLASS.


CLASS lcl_vehicle IMPLEMENTATION.
  METHOD accelerate.
    speed_in_kmh += value.
  ENDMETHOD.

  METHOD break.
  IF value > speed_in_kmh.
  RAISE EXCEPTION NEW cx_abap_invalid_value( ).
  ENDIF.

    speed_in_kmh -= value.
  ENDMETHOD.

  METHOD to_string.
      returning = |{ make } { model } ( { speed_in_kmh  }kmh)|.
  ENDMETHOD.

ENDCLASS.
