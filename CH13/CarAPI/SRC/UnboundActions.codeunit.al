codeunit 50200 "PKT Unbound Actions"
{
    procedure GetSalesAmountForCustomer(CustomerNo: Code[20]) totalSales: Decimal;
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Sell-to Customer No.", CustomerNo);
        if SalesLine.FindSet() then
            repeat
                totalSales += SalesLine."Line Amount";
            until SalesLine.Next() = 0;
    end;
}