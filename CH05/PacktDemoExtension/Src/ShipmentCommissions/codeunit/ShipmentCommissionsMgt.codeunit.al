codeunit 50104 "PKT Shipment Commission Mgt"
{

    //Implementation with events (comment it if you want to use the interface-based implementation)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure AssignShipmentCommission(var SalesHeader: Record "Sales Header")
    var
        total: Decimal;
    begin
        GetShipmentCommission(SalesHeader, total);
        AddItemCharge(SalesHeader, total);
    end;

    //Implementation with Interface (uncomment it if you want to test)
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    // local procedure AssignShipmentCommission(var SalesHeader: Record "Sales Header")
    // var
    //     PacktSetup: Record "PKT Packt Setup";
    //     IShipmentCommissionCalculation: Interface "PKT IShipmentCommissionCalculation";
    //     total: Decimal;
    // begin
    //     PacktSetup.Get();
    //     IShipmentCommissionCalculation := PacktSetup."Shipmt Commission Calc. Method";
    //     IShipmentCommissionCalculation.GetShipmentCommission(SalesHeader, total);
    //     AddItemCharge(SalesHeader, total);
    // end;

    procedure GetShipmentCommission(SalesHeader: Record "Sales Header"; var total: Decimal)
    var
        SalesLine: Record "Sales Line";
        Handled, HandledLine : Boolean;
    begin
        OnBeforeGetShipmentCommission(SalesHeader, Handled, total);
        if Handled then
            exit;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
                OnBeforeCalculateShipmentCommissionLine(SalesLine, total, HandledLine);
                if not HandledLine then begin
                    if SalesLine.Quantity < 10 then
                        total += 1.5
                    else
                        total += 5;
                end;
                OnAfterCalculateShipmentCommissionLine(SalesLine, total);
            until SalesLine.Next() = 0;
        OnAfterGetShipmentCommission(SalesHeader, total);
    end;

    local procedure AddItemCharge(SalesHeader: Record "Sales Header"; totalCharge: Decimal)
    var
        SalesLine: Record "Sales Line";
        PacktSetup: Record "PKT Packt Setup";
        MissingDefaultChargeItem: Label 'Missing Default Charge (Item) in Packt Setup.';
    begin
        PacktSetup.Get();
        if PacktSetup."Default Charge (Item)" = '' then
            Error(MissingDefaultChargeItem);
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := GetNextLineNo(SalesHeader);
        SalesLine.Validate(Type, SalesLine.type::"Charge (Item)");
        SalesLine.Validate("No.", PacktSetup."Default Charge (Item)");
        SalesLine.Validate(Quantity, 1);
        SalesLine.Validate("Unit Price", totalCharge);
        SalesLine.Insert(true);
    end;

    local procedure GetNextLineNo(SalesHeader: Record "Sales Header"): Integer
    var
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindLast() then
            LineNo := SalesLine."Line No." + 10000
        else
            LineNo := 10000;
        exit(LineNo);
    end;


    [IntegrationEvent(true, false)]
    local procedure OnBeforeGetShipmentCommission(var SalesHeader: Record "Sales Header"; var Handled: Boolean; var total: Decimal)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterGetShipmentCommission(var SalesHeader: Record "Sales Header"; var Total: Decimal)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCalculateShipmentCommissionLine(var SalesLine: Record "Sales Line"; var Total: Decimal; var HandledLine: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCalculateShipmentCommissionLine(var SalesLine: Record "Sales Line"; var Total: Decimal)
    begin
    end;

}