@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FLights CDS view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZR_T_FLIGHTS 
as select from zesflight 
composition[1..*] of ZR_T_BOOKINGS as _Booking
association[1] to /dmo/carrier as _Airline on $projection.CarrierId = _Airline.carrier_id
association to ZR_T_CONNECTION as _Connection on $projection.CarrierId = _Connection.CarrierId and $projection.ConnectionId = _Connection.ConnectionId
association[1] to /dmo/airport as _AirportFrom on $projection.airportfromid = _AirportFrom.airport_id
{

  key carrier_id as CarrierId,
  key connection_id as ConnectionId,
  key flight_date as FlightDate,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  price as Price,
  currency_code as CurrencyCode,
  plane_type_id as PlaneTypeId,
  seats_max as SeatsMax,
  seats_occupied as SeatsOccupied,
 
  concat( cast( div( seats_occupied * 100, seats_max ) as abap.char( 100 ) ), '%' ) as SeatPercentage,
  
  
  
 _Booking,

  //count(distinct _Booking2.ZusammenID) as COUTNEW,
  _Connection,
  _Connection.AirportFromId,
  _Connection.AirportToId,
  _AirportFrom,
  concat(_Connection.AirportFromId, concat_with_space(' nach ', _Connection.AirportToId, 1)) as header,
  _Connection.DepartureTime,
  _Connection.ArrivalTime,
  
  concat_with_space(cast(_Connection.Distance as abap.char(100)), _Connection.DistanceUnit, 1) as Distance,
  local_last_changed_at as LocalLastChangedAt,
  last_changed_at as LastChangedAt,
   
  _Airline,
  _Airline.name as AirlineName,
  
  case
      when dats_tims_to_tstmp(flight_date, _Connection.ArrivalTime, $session.user_timezone, $session.client, 'NULL') <
          dats_tims_to_tstmp(flight_date, _Connection.DepartureTime, $session.user_timezone, $session.client, 'NULL')
      then
         division(
             tstmp_seconds_between(
                 dats_tims_to_tstmp(flight_date, _Connection.DepartureTime, $session.user_timezone, $session.client, 'NULL'),
                 tstmp_add_seconds(dats_tims_to_tstmp(flight_date, _Connection.ArrivalTime, $session.user_timezone, $session.client, 'NULL'), cast (86400  as abap.dec(15, 0)), 'NULL'),
                 'NULL'
             ),
             3600,
             2
         )
      else
         division(
             tstmp_seconds_between(
                 dats_tims_to_tstmp(flight_date, _Connection.DepartureTime, $session.user_timezone, $session.client, 'NULL'),
                 dats_tims_to_tstmp(flight_date, _Connection.ArrivalTime, $session.user_timezone, $session.client, 'NULL'),
                 'NULL'
             ),
             3600,
             2
         )
      end                                                                                            as Duration,
           floor ( $projection.Duration ) as DurationH,
        ceil( ($projection.Duration - $projection.DurationH)*60 ) as DurationM,
 
      concat_with_space( concat(cast( $projection.DurationH as abap.char(100) ), 'h'), concat(cast( $projection.DurationM as abap.char(100) ), 'min' ), 1 ) as FlightDuration
 
     
 
  
} where flight_date > $session.system_date 


