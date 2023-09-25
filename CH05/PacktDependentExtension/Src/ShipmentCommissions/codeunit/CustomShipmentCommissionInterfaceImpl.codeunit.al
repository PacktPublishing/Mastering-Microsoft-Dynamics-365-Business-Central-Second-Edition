codeunit 50201 "CUST Shipmt Comm. Calc. Custom" implements "PKT IShipmentCommissionCalculation"
{
    //Custom calculation (fixed price)
    procedure GetShipmentCommission(SalesHeader: Record "Sales Header"; var total: Decimal)
    begin
        total := AssignFixedPrice()
    end;

    local procedure AssignFixedPrice(): Decimal
    var
        PacktSetup: Record "PKT Packt Setup";
    begin
        PacktSetup.Get();
        exit(PacktSetup."CUST_Default Charge");
    end;
}