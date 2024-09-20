CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    DATA conn_counter  TYPE i.

    CLASS-DATA number_of_vehicles TYPE i.


  METHODS get_output
  returning VALUE(r_output) type string.



 METHODS set_attributes
      IMPORTING i_carrier_id    TYPE /dmo/carrier_ID
                i_connection_id TYPE /dmo/connection_id
      RAISING   cx_abap_invalid_value.



ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD get_output.
  r_output = |Carrier: { carrier_id } Connection: { connection_id }|.
  ENDMETHOD.



  METHOD set_attributes.
  if i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
  RAISE EXCEPTION NEW cx_abap_invalid_value( ).
  ENDIF.
  carrier_id = i_carrier_id.
  connection_id = i_connection_id.

  ENDMETHOD.


ENDCLASS.
