@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Flights CDS view'
@ObjectModel: {
  usageType.dataClass: #MIXED, 
  usageType.serviceQuality: #X, 
  usageType.sizeCategory: #S
}
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_T_FLIGHTS003
  provider contract transactional_query 
  
  as projection on ZR_T_FLIGHTS 
  {
  @EndUserText.quickInfo: 'Flight Reference Scenario: Carrier ID'
  key CarrierId,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Connection ID'
  key ConnectionId,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Flight Date'
  key FlightDate,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Flight Price'
  @Semantics.amount.currencyCode: 'CurrencyCode'
  Price,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Currency Code'
  CurrencyCode,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Plane Type ID'
  PlaneTypeId,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Plane Seats Max'
  SeatsMax,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Plane Seats Occupied'
  SeatsOccupied,
  SeatPercentage,
  @EndUserText.quickInfo: 'Flight Reference Scenario: From Airport'
  AirportFromId,
  @EndUserText.quickInfo: 'Flight Reference Scenario: To Airport'
  AirportToId,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Departure Time'
  DepartureTime,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Arrival Time'
  ArrivalTime,
  @EndUserText.quickInfo: 'Flight Reference Scenario: Flight Distance'
  Distance,

  header,
  _Booking : redirected to composition child ZC_T_BOOKINGS002,
  _Airline,
  AirlineName,
  _Connection,
  FlightDuration
  } 
