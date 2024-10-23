@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'FLights CDS view'
}
@Objectmodel: {
  Usagetype.Dataclass: #MIXED, 
  Usagetype.Servicequality: #X, 
  Usagetype.Sizecategory: #S
}
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_T_FLIGHTS000
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_T_FLIGHTS
{
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Carrier ID'
  }
  key CarrierId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Connection ID'
  }
  key ConnectionId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Flight Date'
  }
  key FlightDate,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Flight Price'
  }
  @Semantics: {
    Amount.Currencycode: 'CurrencyCode'
  }
  Price,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Currency Code'
  }
  CurrencyCode,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Plane Type ID'
  }
  PlaneTypeId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Plane Seats Max'
  }
  SeatsMax,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Plane Seats Occupied'
  }
  SeatsOccupied,
  SeatPercentage,
  _Booking : redirected to composition child ZC_T_BOOKINGS
  
}
