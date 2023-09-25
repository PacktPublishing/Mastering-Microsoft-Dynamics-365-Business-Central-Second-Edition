page 50202 PKTCustomerAPI
{
    PageType = API;
    Caption = 'customer';
    APIPublisher = 'packt';
    APIVersion = 'v1.0';
    APIGroup = 'customapi';
    EntityName = 'customer';
    EntitySetName = 'customers';
    SourceTable = Customer;
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(no; Rec."No.")
                {
                    Caption = 'no', Locked = true;
                }
                field(name; Rec.Name)
                {
                    Caption = 'name', Locked = true;
                }
                field(id; Rec.SystemId)
                {
                    Caption = 'Id', Locked = true;
                }
                field(balanceDue; Rec."Balance Due")
                {
                    Caption = 'balanceDue', Locked = true;
                }
                field(creditLimit; Rec."Credit Limit (LCY)")
                {
                    Caption = 'creditLimit', Locked = true;
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'currencyCode', Locked = true;
                }
                field(email; Rec."E-Mail")
                {
                    Caption = 'email', Locked = true;
                }
                field(balance; Rec."Balance (LCY)")
                {
                    Caption = 'balance', Locked = true;
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'countryRegionCode', Locked = true;
                }
                field(netChange; Rec."Net Change")
                {
                    Caption = 'netChange', Locked = true;
                }
                field(noOfOrders; Rec."No. of Orders")
                {
                    Caption = 'noOfOrders', Locked = true;
                }
                field(noOfReturnOrders; Rec."No. of Return Orders")
                {
                    Caption = 'noOfReturnOrders', Locked = true;
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'phoneNo', Locked = true;
                }
                field(salesLCY; Rec."Sales (LCY)")
                {
                    Caption = 'salesLCY', Locked = true;
                }
                field(shippedNotInvoiced; Rec."Shipped Not Invoiced")
                {
                    Caption = 'shippedNotInvoiced', Locked = true;
                }
            }
        }
    }

    [ServiceEnabled]
    procedure Clone(var ActionContext: WebServiceActionContext)
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer.TransferFields(Rec, false);
        Customer.Name := 'CUSTOMER CLONED VIA BOUND ACTION';
        Customer.Insert(true);
        ActionContext.SetResultCode(WebServiceActionResultCode::Created);
    end;

}
