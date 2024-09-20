*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    CLASS-DATA conn_counter TYPE i READ-ONLY.

*    METHODS set_attributes
*      IMPORTING
*        i_carrier_id    TYPE /dmo/carrier_id
*        i_connection_id TYPE /dmo/connection_id
*      RAISING
*        cx_abap_invalid_value.

    METHODS constructor
      IMPORTING i_connection_id TYPE /dmo/connection_id
                i_carrier_id    TYPE /dmo/carrier_id
      RAISING   cx_abap_invalid_value.

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

  PRIVATE SECTION.
    DATA carrier_id      TYPE /dmo/carrier_id.
    DATA connection_id   TYPE /dmo/connection_id.
    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id   TYPE /dmo/airport_to_id.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.
  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION NEW cx_abap_invalid_value( ).
    ENDIF.

    SELECT single FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id
      WHERE carrier_id = @i_carrier_id AND connection_id = @i_connection_id
      INTO ( @me->airport_to_id, @me->airport_from_id ).


    connection_id = i_connection_id.
    carrier_id = i_carrier_id.
    airport_from_id = me->airport_from_id.
    airport_to_id = me->airport_to_id.

    conn_counter += 1.
  ENDMETHOD.

  METHOD get_output.
    APPEND |------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id    }| TO r_output.
    APPEND |Connection:  { connection_id }| TO r_output.
    " TODO: check spelling: Depature (typo) -> Departure (ABAP cleaner)
    APPEND |Departure:     { me->airport_from_id }| TO r_output.
    APPEND |Arrival:  { me->airport_to_id }| TO r_output.
    APPEND |------------------------------| TO r_output.
  ENDMETHOD.

*  METHOD set_attributes.
*    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value.
*    ENDIF.
*
*    carrier_id    = i_carrier_id.
*    connection_id = i_connection_id.
*
*  ENDMETHOD.



ENDCLASS. "* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
