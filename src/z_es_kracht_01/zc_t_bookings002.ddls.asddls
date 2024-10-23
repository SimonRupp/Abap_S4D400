@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'CDS View Bookings'
}
@ObjectModel: {
  usageType.dataClass: #MIXED, 
  usageType.serviceQuality: #X, 
  usageType.sizeCategory: #S
}
@AccessControl.authorizationCheck: #CHECK
define view entity ZC_T_BOOKINGS002
  as projection on ZR_T_BOOKINGS
{
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Travel ID'
  }
  key TravelId,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Booking ID'
  }
  key BookingId,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Booking Date'
  }
  BookingDate,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Customer ID'
  }
  CustomerId,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Carrier ID'
  }
  CarrierId,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Connection ID'
  }
  ConnectionId,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Flight Date'
  }
  FlightDate,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Flight Price'
  }
  @Semantics: {
    amount.currencyCode: 'CurrencyCode'
  }
  FlightPrice,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Currency Code'
  }
  Storniert,
  airlinename,
  @EndUserText: {
    quickInfo: 'Flight Reference Scenario: Cancelld'
  }
  CurrencyCode,
 AirFId,
 AirTId,
 headerstring,
 CustomerFullName,
 BookingIDNumber,
  
  _Flight : redirected to parent ZC_T_FLIGHTS003
  
  
}
