pageextension 50102 "PKT CustomerCardExt" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("PKT Customer Category Code"; Rec."PKT Customer Category Code")
            {
                ToolTip = 'Customer Category';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast("F&unctions")
        {

            action("PKT Assign default category")
            {
                Caption = 'Assign Default Category';
                ToolTip = 'Assigns a Default Category to the current Customer';
                Image = ChangeCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    CustomerCategoryMgt: Codeunit "PKT Customer Category Mgt";
                begin
                    CustomerCategoryMgt.AssignDefaultCategory(Rec."No.");
                end;
            }
        }
    }
}