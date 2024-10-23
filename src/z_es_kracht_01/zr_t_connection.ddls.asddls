@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View Connection'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZR_T_CONNECTION as select from zesconnection

{
  key carrier_id as CarrierId,
  key connection_id as ConnectionId,
  airport_from_id as AirportFromId,
  airport_to_id as AirportToId,
  departure_time as DepartureTime,
  arrival_time as ArrivalTime,
  distance as Distance,
  distance_unit as DistanceUnit
}
