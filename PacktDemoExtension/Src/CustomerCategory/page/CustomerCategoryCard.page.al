page 50101 "PKT Customer Category Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "PKT Customer Category";
    Caption = 'Customer Category Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field(EnableNewsletter; Rec.EnableNewsletter)
                {
                    ApplicationArea = All;
                }
                field(FreeGiftsAvailable; Rec.FreeGiftsAvailable)
                {
                    ApplicationArea = All;
                }
            }

            group(Administration)
            {
                Caption = 'Administration';
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }

            group(Statistics)
            {
                Caption = 'Statistics';
                field(TotalCustomersForCategory; Rec.TotalCustomersForCategory)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalSalesAmount; TotalSalesAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Sales Order Amount';
                    Editable = false;
                    Style = Strong;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        TotalSalesAmount := Rec.GetSalesAmount();
    end;

    var
        TotalSalesAmount: Decimal;
}