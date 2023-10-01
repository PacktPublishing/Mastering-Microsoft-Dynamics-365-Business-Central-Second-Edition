codeunit 50103 "PKT General Event Subscribers"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeCheckCustBlockage, '', false, false)]
    local procedure OnBeforeCheckCustBlockageByCategory(SalesHeader: Record "Sales Header"; CustCode: Code[20]; var ExecuteDocCheck: Boolean; var IsHandled: Boolean; var TempSalesLine: Record "Sales Line" temporary)
    var
        Customer: Record Customer;
        CustomerCategory: Record "PKT Customer Category";
        CustBlockByCategoryLbl: Label 'Customer %1 is blocked by category';
    begin
        IsHandled := true;
        if Customer.Get(CustCode) then begin
            if Customer."PKT Customer Category Code" <> '' then begin
                CustomerCategory.Get(Customer."PKT Customer Category Code");
                if CustomerCategory.Blocked then
                    Error(CustBlockByCategoryLbl, Customer."No.");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterItemLedgerEntryInsert(var Rec: Record "Item Ledger Entry")
    var
        Customer: Record Customer;
    begin
        if Rec."Entry Type" = Rec."Entry Type"::Sale then begin
            if Customer.Get(Rec."Source No.") then begin
                Rec."PKT Customer Category Code" := Customer."PKT Customer Category Code";
                Rec.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforeManualReleasePurchaseDoc, '', false, false)]
    local procedure QualityCheckForReleasingPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        VendorQuality: Record "PKT Vendor Quality";
        PacktSetup: Record "PKT Packt Setup";
        ErrNoMinimumRate: Label 'Vendor %1 has a rate of %2 and it''s under the required minimum value (%3)';
    begin
        PacktSetup.Get();
        if VendorQuality.Get(PurchaseHeader."Buy-from Vendor No.") then begin
            if VendorQuality.Rate < PacktSetup."Minimum Accepted Vendor Rate" then
                Error(ErrNoMinimumRate, PurchaseHeader."Buy-from Vendor No.",
                Format(VendorQuality.Rate), Format(PacktSetup."Minimum Accepted Vendor Rate"));
        end;
    end;

}