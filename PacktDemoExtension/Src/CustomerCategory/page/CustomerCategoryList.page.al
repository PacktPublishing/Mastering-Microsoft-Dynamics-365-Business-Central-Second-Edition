page 50100 "PKT Customer Category List"
{
    Caption = 'Customer Category List';
    SourceTable = "PKT Customer Category";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "PKT Customer Category Card";
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
                }
                field(Description; Rec.Description)
                {
                }
                field(Default; Rec.Default)
                {
                }
                field(TotalCustomersForCategory; Rec.TotalCustomersForCategory)
                {
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
                Caption = 'Create default category';
                ToolTip = 'Create default category';
                Image = CreateForm;
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