codeunit 50200 "CUST_CustomShptCommissionMgt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PKT Shipment Commission Mgt", 'OnBeforeGetShipmentCommission', '', false, false)]
    local procedure CustomChargeCalculationHandler(var SalesHeader: Record "Sales Header"; var Handled: Boolean; var total: Decimal)
    begin
        total := AssignFixedPrice();
        Handled := true;
    end;

    local procedure AssignFixedPrice(): Decimal
    var
        PacktSetup: Record "PKT Packt Setup";
    begin
        PacktSetup.Get();
        exit(PacktSetup."CUST_Default Charge");
    end;
}