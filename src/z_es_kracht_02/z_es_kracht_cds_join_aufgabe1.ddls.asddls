@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Join für aufgabe 2_1'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Z_ES_KRACHT_CDS_Join_Aufgabe1
  as select from zesbooking    as _Booking
    inner join   zesconnection as _Connection on _Connection.connection_id = _Booking.connection_id
    inner join   zescustomer   as _Customer   on _Customer.customer_id = _Booking.customer_id
    inner join   zesflight     as _Flight     on _Flight.connection_id = _Booking.connection_id
    inner join   /dmo/airport  as _Airport    on  _Airport.airport_id = _Connection.airport_from_id
    inner join   /dmo/airport  as _AirportTo  on _AirportTo.airport_id = _Connection.airport_to_id
                                            
  
{
  key _Booking.booking_id             as BookingId,
  key _Connection.carrier_id          as CarrierId,
  key _Customer.customer_id           as CustomerId,
  key _Customer.first_name            as FirstName,
  key _Customer.last_name             as LastName,
  key _Flight.flight_date             as FlightDate,
      _Airport.name                   as AirportName,
      _Booking.booking_date           as BookingDate,
      _Booking.flight_price           as FlightPrice,
      _Booking.currency_code          as CurrencyCode,
      _Connection.airport_from_id     as AirportFromId,
      _Connection.airport_to_id       as AirportToId,
      _Connection.departure_time      as DepartureTime,
      _Connection.arrival_time        as ArrivalTime,
      _Connection.distance            as Distance,
      _Connection.distance_unit       as DistanceUnit,
      _Flight.plane_type_id           as PlaneTypeId,
      _Flight.seats_max               as SeatsMax,
      _Flight.seats_occupied          as SeatsOccupied
}
