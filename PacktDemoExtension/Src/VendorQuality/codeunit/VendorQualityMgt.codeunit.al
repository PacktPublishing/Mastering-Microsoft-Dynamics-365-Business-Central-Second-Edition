codeunit 50102 "PKT Vendor Quality Mgt"
{
    procedure CalculateVendorRate(var VendorQuality: Record "PKT Vendor Quality")
    var
        Handled: Boolean;
    begin
        OnBeforeCalculateVendorRate(VendorQuality, Handled);
        //This is the company's criteria to assign the Vendor rate.        
        VendorRateCalculation(VendorQuality, Handled);
        OnAfterCalculateVendorRate(VendorQuality);
    end;

    local procedure VendorRateCalculation(var VendorQuality: Record "PKT Vendor Quality"; var Handled: Boolean)
    begin
        if Handled then
            exit;
        VendorQuality.Rate := (VendorQuality.ScoreDelivery + VendorQuality.ScoreItemQuality +
          VendorQuality.ScorePackaging + VendorQuality.ScorePricing) / 4;
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCalculateVendorRate(var VendorQuality: Record "PKT Vendor Quality"; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCalculateVendorRate(var VendorQuality: Record "PKT Vendor Quality")
    begin
    end;

    procedure UpdateVendorQualityStatistics(var VendorQuality: Record "PKT Vendor Quality")
    var
        Year: Integer;
        DW: Dialog;
        DialogMessage: Label 'Calculating Vendor statistics...';
    begin
        DW.OPEN(DialogMessage);
        Year := DATE2DMY(TODAY, 3);
        VendorQuality.InvoicedYearN := GetInvoicedAmount(VendorQuality."Vendor No.", DMY2DATE(1, 1, Year), TODAY);
        VendorQuality.InvoicedYearN1 := GetInvoicedAmount(VendorQuality."Vendor No.", DMY2DATE(1, 1, Year - 1), DMY2DATE(31, 12, Year - 1));
        VendorQuality.InvoicedYearN2 := GetInvoicedAmount(VendorQuality."Vendor No.", DMY2DATE(1, 1, Year - 2), DMY2DATE(31, 12, Year - 2));
        VendorQuality.DueAmount := GetDueAmount(VendorQuality."Vendor No.", TRUE);
        VendorQuality.AmountNotDue := GetDueAmount(VendorQuality."Vendor No.", FALSE);
        DW.Close();
    end;

    local procedure GetInvoicedAmount(VendorNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Total: Decimal;
    begin
        VendorLedgerEntry.SetRange("Vendor No.", VendorNo);
        VendorLedgerEntry.SetFilter("Document Date", '%1..%2', StartDate, EndDate);
        VendorLedgerEntry.SetLoadFields("Purchase (LCY)");
        if VendorLedgerEntry.FindSet() then
            repeat
                Total += VendorLedgerEntry."Purchase (LCY)";
            until VendorLedgerEntry.Next() = 0;

        exit(Total * (-1));
    end;

    local procedure GetDueAmount(VendorNo: Code[20]; Due: Boolean): Decimal
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Total: Decimal;
    begin
        VendorLedgerEntry.SetRange("Vendor No.", VendorNo);
        VendorLedgerEntry.SetRange(Open, TRUE);
        if Due then
            VendorLedgerEntry.SetFilter("Due Date", '< %1', TODAY)
        else
            VendorLedgerEntry.SetFilter("Due Date", '> %1', TODAY);
        VendorLedgerEntry.SETAUTOCALCFIELDS(VendorLedgerEntry."Remaining Amt. (LCY)");
        if VendorLedgerEntry.FindSet() then
            repeat
                Total += VendorLedgerEntry."Remaining Amt. (LCY)";
            until VendorLedgerEntry.Next() = 0;

        exit(Total * (-1));
    end;
}