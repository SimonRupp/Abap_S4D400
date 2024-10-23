@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Join für aufgabe 2_3'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Z_ES_KRACHT_CDS_Join_Aufgabe3 
as select from zesconnection as _Connection //hab die connection Tabelle geändert
inner join zesflight as _Flight
on _Flight.connection_id = _Connection.connection_id
inner join /dmo/airport as _Airport
on _Airport.airport_id = _Connection.airport_from_id
inner join /dmo/airport as _ArrAirport
on _ArrAirport.airport_id = _Connection.airport_to_id


  {
  key _Flight.flight_date as FlightDate,
  key _Connection.airport_from_id as AirportFromId,
  key _Airport.name as DepartureAirport,
  key _Airport.city as DepatureCity,
  key _Airport.country as DepartureCountry,
  key _Connection.airport_to_id as AirportToId,
  _ArrAirport.name as ArrivalAirport,
  _ArrAirport.city as ArrivalCity,
  _ArrAirport.country as ArrivalCountry,
  _Connection.departure_time as DepartureTime,
  _Connection.arrival_time as ArrivalTime,
  _Flight.price as PricePerPerson,
  _Flight.currency_code as CurrencyCode,
 
  _Flight.seats_max as SeatsMax,
  _Flight.seats_occupied as SeatsOccupied,
  cast(_Flight.seats_max-_Flight.seats_occupied as abap.int4) as SeatsAvailable
  
}
