CLASS z_es_kracht_aufgabe1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_es_kracht_aufgabe1 IMPLEMENTATION.




  METHOD if_oo_adt_classrun~main.
  data tabelle TYPE TABLE of /dmo/connection.


  SELECT FROM /dmo/connection
  FIELDS *
  INTO TABLE @tabelle.

   Insert  zesconnection from table @tabelle.


  ENDMETHOD.
ENDCLASS.
