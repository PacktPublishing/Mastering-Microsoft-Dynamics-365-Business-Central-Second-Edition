codeunit 50106 "PKT Ship. Commission Calc Base" implements "PKT IShipmentCommissionCalculation"
{
    //BASE Shipment Commission Calculation
    procedure GetShipmentCommission(SalesHeader: Record "Sales Header"; var total: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
            begin
                if SalesLine.Quantity < 10 then
                    total += 1.5
                else
                    total += 5;
            end
            until SalesLine.Next() = 0;
    end;
}