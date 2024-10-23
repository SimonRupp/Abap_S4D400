@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View Bookings'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZR_T_BOOKINGS as select from zesbooking
association to parent ZR_T_FLIGHTS as _Flight on $projection.ConnectionId = _Flight.ConnectionId and $projection.CarrierId = _Flight.CarrierId and $projection.FlightDate = _Flight.FlightDate
association to ZR_T_CONNECTION as _Connection on $projection.CarrierId = _Connection.CarrierId and $projection.ConnectionId = _Connection.ConnectionId
association to /dmo/carrier as _Carrier on $projection.CarrierId = _Carrier.carrier_id
association to /dmo/customer as _Customer on $projection.CustomerId = _Customer. customer_id
{
  key travel_id as TravelId,
  key booking_id as BookingId,
  booking_date as BookingDate,
  customer_id as CustomerId,
  carrier_id as CarrierId,
  connection_id as ConnectionId,
  flight_date as FlightDate,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  flight_price as FlightPrice,
  currency_code as CurrencyCode,
  _Flight,
  cancelld as Storniert,

  _Connection,
  _Connection.AirportFromId as AirFId,
  _Connection.AirportToId as AirTId,
  _Carrier,
  _Carrier.name as airlinename,
  concat( $projection.AirFId, concat_with_space( ' nach ', $projection.AirTId, 1 ) ) as headerstring,
  concat( $projection.TravelId, $projection.BookingId ) as BookingIDNumber,
  _Customer,
  _Customer.first_name as CFirstName,
  _Customer.last_name as CLastName,
  concat_with_space($projection.CFirstName, $projection.CLastName, 1) as CustomerFullName
  
  
  
  
  
  
  
  
  
  

  
  
  
}

