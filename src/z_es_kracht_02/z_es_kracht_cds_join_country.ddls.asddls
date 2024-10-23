//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Join für Country abfrage'
//@Metadata.ignorePropagatedAnnotations: false
//@ObjectModel.usageType:{
//  serviceQuality: #X,
//  sizeCategory: #S,
//  dataClass: #MIXED
//}
//define view entity Z_ES_KRACHT_CDS_Join_Country 
//
//with parameters
//country_name : /dmo/agency_name
//
//
//as select from zesconnection as _Connection
//inner join zesflight as _Flight
//on _Flight.connection_id = _Connection.connection_id
//inner join /dmo/airport as _Airport
//on _Airport.airport_id = _Connection.airport_to_id or
//_Airport.airport_id = _Connection.airport_from_id
//{
//  key _Airport.airport_id as AirportId,
//  key _Connection.carrier_id as CarrierId,
//  key _Connection.connection_id as ConnectionId,
//  key _Flight.flight_date as FlightDate,
//  _Airport.name as Name,
//  _Airport.city as City,
//  _Airport.country as Country,
//  _Connection.airport_from_id as AirportFromId,
//  _Connection.airport_to_id as AirportToId,
//  _Connection.departure_time as DepartureTime,
//  _Connection.arrival_time as ArrivalTime,
//  _Connection.distance as Distance,
//  _Connection.distance_unit as DistanceUnit,
//  _Flight.price as Price,
//  _Flight.currency_code as CurrencyCode,
//  _Flight.plane_type_id as PlaneTypeId,
//  _Flight.seats_max as SeatsMax,
//  _Flight.seats_occupied as SeatsOccupied,
//  _Flight.local_last_changed_at as LocalLastChangedAt,
//  _Flight.last_changed_at as LastChangedAt
//
//  
//} where $parameters.country_name = _Airport.country

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Join für Country abfrage'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Z_ES_KRACHT_CDS_Join_Country 

with parameters
country_name : /dmo/agency_name


as select from zesconnection as _Connection
inner join zesflight as _Flight
on _Flight.connection_id = _Connection.connection_id
inner join /dmo/airport as _Airport
on _Airport.airport_id = _Connection.airport_to_id or
_Airport.airport_id = _Connection.airport_from_id
{
  key _Airport.airport_id as AirportId,
  key _Connection.carrier_id as CarrierId,
  key _Connection.connection_id as ConnectionId,
  key _Flight.flight_date as FlightDate,
  _Airport.name as Name,
  _Airport.city as City,
  _Airport.country as Country,
  _Connection.airport_from_id as AirportFromId,
  _Connection.airport_to_id as AirportToId,
  _Flight.plane_type_id as PlaneTypeId

  
} where $parameters.country_name = _Airport.country

