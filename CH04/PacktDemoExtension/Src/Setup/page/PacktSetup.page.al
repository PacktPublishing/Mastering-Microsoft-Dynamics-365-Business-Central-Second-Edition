page 50104 "PKT Packt Setup"
{
    Caption = 'Packt Extension Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PKT Packt Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Minimum Accepted Vendor Rate"; Rec."Minimum Accepted Vendor Rate")
                {
                }
                field("Gift Tolerance Qty"; Rec."Gift Tolerance Qty")
                {
                }
                field("Default Charge (Item)"; Rec."Default Charge (Item)")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}