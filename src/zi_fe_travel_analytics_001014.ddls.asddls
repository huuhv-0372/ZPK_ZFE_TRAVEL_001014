@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Travel view entity for booking analysis'
@Metadata.allowExtensions: true
define view entity zi_fe_travel_analytics_001014
  as select from zfe_atrav_001014 as Travel
  association [0..1] to /DMO/I_Agency as _Agency on $projection.AgencyID = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer as _Customer on $projection.CustomerID = _Customer.CustomerID
{
  key travel_uuid as TravelUUID,
  travel_id as TravelID,
  agency_id as AgencyID,
  customer_id as CustomerID,
  begin_date as BeginDate,
  end_date as EndDate,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  booking_fee as BookingFee,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  total_price as TotalPrice,
  currency_code as CurrencyCode,
  description as Description,
  overall_status as OverallStatus,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LAST_CHANGED_AT,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  -- Sử dụng CASE để tạo trường boolean
  case
    when total_price > 1000 then 'X' -- Giá trị true
    else ' '                       -- Giá trị false
  end as IsHighValue,
  _Agency,
  _Customer
  
}
