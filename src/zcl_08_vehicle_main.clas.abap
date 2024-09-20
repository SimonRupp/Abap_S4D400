CLASS zcl_08_vehicle_main DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_vehicle_main IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA vehicle TYPE ref to lcl_vehicle. "Vehicle vehicle;
    DATA vehicles TYPE TABLE of REF TO lcl_vehicle. "List<Vehicle> vehicles = new ArrayList<>();

  vehicle = new #(  ).                  "vehicle = new Vehicle();
  vehicle->make = 'Porsche'.
    vehicle->model = 'Gt3 Rs'.
      vehicle->speed_in_kmh = 300.
      APPEND vehicle to vehicles.

  vehicle = new #(  ).                  "vehicle = new Vehicle();
  vehicle->make = 'Audi'.
    vehicle->model = 'a4'.
      vehicle->speed_in_kmh = 100.
        APPEND vehicle to vehicles.

        LOOP at vehicles INTO vehicle.
         out->write( vehicle->to_string( ) ).
        ENDLOOP.

        vehicles[ 1 ]->accelerate( 50 ).
        vehicles[ 2 ]->break( 150 ).

        out->write( vehicles ).

    ENDMETHOD.
ENDCLASS.
