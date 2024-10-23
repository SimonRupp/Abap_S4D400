@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ad'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZC_T_CONNECTION as select from ZR_T_CONNECTION
{
  key CarrierId,
  key ConnectionId,
  AirportFromId,
  AirportToId,
  DepartureTime,
  ArrivalTime,
  Distance,
  DistanceUnit
}
