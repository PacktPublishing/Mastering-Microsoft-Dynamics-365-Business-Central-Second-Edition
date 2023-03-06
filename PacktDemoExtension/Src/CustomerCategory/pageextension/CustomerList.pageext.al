pageextension 50103 "PKT CustomerListExt" extends "Customer List"
{
    actions
    {
        addlast(Processing)
        {
            action("PKT Assign Default Category")
            {
                Image = ChangeCustomer;
                ApplicationArea = All;
                Caption = 'Assign Default Category to all Customers';
                ToolTip = 'Assigns the Default Category to all Customers';

                trigger OnAction();
                var
                    CustomerCategoryMgt: Codeunit "PKT Customer Category Mgt";
                begin
                    CustomerCategoryMgt.AssignDefaultCategory();
                end;
            }
        }
        addlast(Promoted)
        {
            group(PKTCustomerCategory)
            {
                Caption = 'Customer Category';
                actionref(PKTAssingDefaultCategory; "PKT Assign Default Category")
                {
                }
            }
        }
    }

    views
    {
        addlast
        {
            view(CustomersWithoutCategory)
            {
                Caption = 'Customers without Category assigned';
                Filters = where("PKT Customer Category Code" = filter(''));
            }
        }
    }
}