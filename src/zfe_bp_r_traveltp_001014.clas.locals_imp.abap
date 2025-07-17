CLASS LHC_TRAVEL DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Travel
        RESULT result,
      CALCULATETRAVELID FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  Travel~CalculateTravelID .
ENDCLASS.

CLASS LHC_TRAVEL IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CALCULATETRAVELID.
  READ ENTITIES OF ZI_FE_TRAVEL_001014 IN LOCAL MODE
    ENTITY Travel
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(entities).
  DELETE entities WHERE TravelID IS NOT INITIAL.
  Check entities is not initial.
  "Dummy logic to determine object_id
  SELECT MAX( TRAVEL_ID ) FROM ZFE_ATRAV_001014 INTO @DATA(max_object_id).
  "Add support for draft if used in modify
  "SELECT SINGLE FROM FROM ZFE_DTRAV_001014 FIELDS MAX( TravelID ) INTO @DATA(max_orderid_draft). "draft table
  "if max_orderid_draft > max_object_id
  " max_object_id = max_orderid_draft.
  "ENDIF.
  MODIFY ENTITIES OF ZI_FE_TRAVEL_001014 IN LOCAL MODE
    ENTITY Travel
      UPDATE FIELDS ( TravelID )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky          = entity-%tky
        TravelID     = max_object_id + i
  ) ).
  ENDMETHOD.
ENDCLASS.
