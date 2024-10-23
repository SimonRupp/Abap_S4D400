@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'CDS View Bookings'
}
@Objectmodel: {
  Usagetype.Dataclass: #MIXED, 
  Usagetype.Servicequality: #X, 
  Usagetype.Sizecategory: #S
}
@AccessControl.authorizationCheck: #CHECK
define view entity ZC_T_BOOKINGS
  as projection on ZR_T_BOOKINGS
{
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Travel ID'
  }
  key TravelId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Booking ID'
  }
  key BookingId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Booking Date'
  }
  BookingDate,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Customer ID'
  }
  CustomerId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Carrier ID'
  }
  CarrierId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Connection ID'
  }
  ConnectionId,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Flight Date'
  }
  FlightDate,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Flight Price'
  }
  @Semantics: {
    Amount.Currencycode: 'CurrencyCode'
  }
  FlightPrice,
  @Endusertext: {
    Quickinfo: 'Flight Reference Scenario: Currency Code'
  }
  CurrencyCode,
  _Flight : redirected to parent ZC_T_FLIGHTS000
  
}
