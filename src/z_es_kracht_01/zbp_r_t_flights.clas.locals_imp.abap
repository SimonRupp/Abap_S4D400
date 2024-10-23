CLASS lhc_zr_t_bookings DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS updateSeats FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_t_bookings~updateSeats.


ENDCLASS.

CLASS lhc_zr_t_bookings IMPLEMENTATION.



  METHOD updateseats.
    DATA:
      lv_carrier_id    TYPE zr_flight-carrierId,
      lv_connection_id TYPE zr_flight-ConnectionId,
      lv_flight_date   TYPE zr_flight-FlightDate,
      lv_seats_occupied TYPE zr_flight-seatsOccupied,
      delta_seatsOccupied TYPE zr_flight-seatsOccupied.

   READ ENTITIES OF zr_t_flights IN LOCAL MODE
      ENTITY zr_t_bookings
      FIELDS ( ConnectionId FlightDate Storniert )
      WITH CORRESPONDING #( keys )
   RESULT DATA(lt_bookings).

    LOOP AT lt_bookings INTO DATA(ls_booking).

      IF ls_booking-Storniert = 'X'.
        delta_SeatsOccupied = delta_SeatsOccupied - 1.
      ELSE.
        delta_SeatsOccupied = delta_SeatsOccupied + 1.
      ENDIF.

    ENDLOOP.





*   The Key for the Flight is for all bookings in the Table the same, because you filter on the Flight

    lv_carrier_id    = lt_bookings[ 1 ]-CarrierId.
    lv_connection_id = lt_bookings[ 1 ]-ConnectionId.
    lv_flight_date   = lt_bookings[ 1 ]-FlightDate.


    SELECT SINGLE
    FROM zr_t_flights
    fields SeatsOccupied
    where CarrierId = @lv_carrier_id
        AND ConnectionId = @lv_connection_id
        AND FlightDate = @lv_flight_date
        INTO @lv_seats_occupied.

    delta_seatsOccupied = lv_seats_occupied + delta_seatsoccupied.



    MODIFY EntiTy zr_t_flights
    UPDATE FIELDS ( SeatsOccupied )
    WITH VALUE #(
        ( CarrierId = lt_bookings[ 1 ]-CarrierId
          ConnectionId = lt_bookings[ 1 ]-ConnectionId
          FlightDate = lt_bookings[ 1 ]-FlightDate
          seatsOccupied =  delta_seatsOccupied )
    ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_T_FLIGHTS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_t_flights RESULT result.
    METHODS validateseats FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_t_flights~validateseats.

ENDCLASS.

CLASS lhc_ZR_T_FLIGHTS IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateSeats.
  READ ENTITIES OF zr_t_flights IN LOCAL MODE
  ENTITY zr_t_flights
  FIELDS ( SeatsMax SeatsOccupied ) WITH CORRESPONDING #( keys )
  RESULT DATA(flightData).

  LOOP AT flightData INTO DATA(seats).

  IF seats-SeatsOccupied > seats-SeatsMax.

    IF seats-SeatsOccupied - seats-SeatsMax > seats-SeatsMax / 10.

      APPEND VALUE #( %tky = seats-%tky ) to failed-zr_t_flights.
      APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                      text = 'You cannot overbook a flight over 10%') )
                      TO reported-zr_t_flights.

    ELSE.

*     APPEND VALUE #( %tky = seats-%tky ) to failed-zr_t_flights.
      APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-warning
                      text = 'You are overbooking a flight') )
                      TO reported-zr_t_flights.

    ENDIF.

  ENDIF.
  ENDLOOP.

  ENDMETHOD.

ENDCLASS.
