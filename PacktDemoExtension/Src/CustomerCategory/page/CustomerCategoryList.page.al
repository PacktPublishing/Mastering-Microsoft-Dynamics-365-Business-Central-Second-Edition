page 50100 "PKT Customer Category List"
{
    PageType = List;
    SourceTable = "PKT Customer Category";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "PKT Customer Category Card";
    Caption = 'Customer Category List';
    AdditionalSearchTerms = 'ranking, categorization';
    AboutTitle = 'About Customer Categories';
    AboutText = 'Here you can define the **categories** for your customers. You can then categorize your customers via the **Customer Card**.';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;
                }
                field(TotalCustomersForCategory; Rec.TotalCustomersForCategory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Customers for Category';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Default Category")
            {
                Image = CreateForm;
                ApplicationArea = All;
                ToolTip = 'Create default category';
                Caption = 'Create default category';

                trigger OnAction();
                var
                    CustManagement: Codeunit "PKT Customer Category Mgt";
                begin
                    CustManagement.CreateDefaultCategory();
                end;
            }
        }
        area(Promoted)
        {
            group(PKTCustomerCategory)
            {
                Caption = 'Customer Category';
                actionref(CreateDefaultCategory; "Create Default Category")
                {
                }
            }
        }
    }
}