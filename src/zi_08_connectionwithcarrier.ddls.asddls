@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection with Carrier'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_08_ConnectionWithCarrier
 as select from /dmo/connection
 inner join /dmo/carrier on /dmo/connection.carrier_id = /dmo/carrier.carrier_id
{
  key /dmo/connection.carrier_id as CarrierId,
  key /dmo/connection.connection_id as ConnectionId,
  /dmo/carrier.name as Name,
  /dmo/connection.airport_from_id as AirportFromId,
  /dmo/connection.airport_to_id as AirportToId
  }
  
