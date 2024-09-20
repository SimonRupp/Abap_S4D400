CLASS zcl_08_local_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_08_local_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATa connection type ref to lcl_connection.
  data connections TYPE TABLE of ref to lcl_connection.

  connection = NEW #(  ).

  TRY.
      connection->set_attributes( i_carrier_id = 'MH' i_connection_id = '12' ).
      APPEND connection to connections.
    CATCH cx_abap_invalid_value.
      "handle exception
  ENDTRY.


  connection = NEW #(  ).
  connection->carrier_id = 'AiB'.
  connection->connection_id = '09'.
  connection->conn_counter = 2.
  APPEND connection to connections.

  Loop at connections into connection.
  out->write( connection->get_output(  ) ).
  endLoop.


  ENDMETHOD.


ENDCLASS.
