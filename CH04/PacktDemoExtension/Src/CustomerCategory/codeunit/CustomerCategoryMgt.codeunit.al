codeunit 50100 "PKT Customer Category Mgt"
{
    procedure CreateDefaultCategory()
    var
        CustomerCategory: Record "PKT Customer Category";
        DefaultCodeTxt: Label 'DEFAULT';
        DefaultDescriptionTxt: Label 'Default Customer Category';
    begin
        CustomerCategory.Code := DefaultCodeTxt;
        CustomerCategory.Description := DefaultDescriptionTxt;
        CustomerCategory.Default := true;
        if CustomerCategory.Insert() then;
    end;

    procedure AssignDefaultCategory(CustomerCode: Code[20])
    var
        Customer: Record Customer;
        CustomerCategory: Record "PKT Customer Category";
    begin
        //Set default category for a Customer        
        Customer.Get(CustomerCode);
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            Customer.Validate("PKT Customer Category Code", CustomerCategory.Code);
            Customer.Modify();
        end;
    end;

    procedure AssignDefaultCategory()
    var
        Customer: Record Customer;
        CustomerCategory: Record "PKT Customer Category";
    begin
        //Set default category for ALL Customer       
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            Customer.SetFilter("PKT Customer Category Code", '%1', '');
            Customer.ModifyAll("PKT Customer Category Code", CustomerCategory.Code, true);
        end;
    end;

    //Returns the number of Customers without an assigned Customer Category
    procedure GetTotalCustomersWithoutCategory(): Integer
    var
        Customer: Record Customer;
    begin
        Customer.SetRange("PKT Customer Category Code", '');
        exit(customer.Count());
    end;

    procedure GetSalesAmount(CustomerCategoryCode: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        TotalAmount: Decimal;
    begin
        Customer.SetCurrentKey("PKT Customer Category Code");
        Customer.SetRange("PKT Customer Category Code", CustomerCategoryCode);
        if Customer.FindSet() then
            repeat
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Sell-to Customer No.", Customer."No.");
                SalesLine.SetLoadFields("Line Amount");
                if SalesLine.FindSet() then
                    repeat
                        TotalAmount += SalesLine."Line Amount";
                    until SalesLine.Next() = 0;
            until Customer.Next() = 0;

        exit(TotalAmount);
    end;

}