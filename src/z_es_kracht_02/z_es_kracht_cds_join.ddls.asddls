@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Join Ansatz'
@Metadata.ignorePropagatedAnnotations: false
define view entity Z_ES_KRACHT_CDS_Join 
as select from zesconnection as _Connection //hab die connection Tabelle geändert
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
} 
