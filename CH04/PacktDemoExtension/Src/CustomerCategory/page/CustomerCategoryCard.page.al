page 50101 "PKT Customer Category Card"
{
    Caption = 'Customer Category Card';
    SourceTable = "PKT Customer Category";
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Default; Rec.Default)
                {
                }
                field(EnableNewsletter; Rec.EnableNewsletter)
                {
                }
                field(FreeGiftsAvailable; Rec.FreeGiftsAvailable)
                {
                }
            }

            group(Administration)
            {
                Caption = 'Administration';
                field(Blocked; Rec.Blocked)
                {
                }
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                field(TotalCustomersForCategory; Rec.TotalCustomersForCategory)
                {
                    Editable = false;
                }
                field(TotalSalesAmount; TotalSalesAmount)
                {
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