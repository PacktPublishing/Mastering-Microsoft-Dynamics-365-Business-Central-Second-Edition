page 61122 "PKT No. Series Proposal Sub"
{

    Caption = 'No. Series Proposals';
    PageType = ListPart;
    SourceTable = "PKT No. Series Proposal";
    SourceTableTemporary = true;
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    InherentPermissions = X;
    InherentEntitlements = X;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Series Code"; Rec."Series Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Starting No."; Rec."Starting No.")
                {
                    ApplicationArea = All;
                }
                field("Increment-by No."; Rec."Increment-by No.")
                {
                    ApplicationArea = All;
                }
                field("Ending No."; Rec."Ending No.")
                {
                    ApplicationArea = All;
                }
                field("Warning No."; Rec."Warning No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    internal procedure Load(var NoSeriesGenerated: Record "PKT No. Series Proposal")
    begin
        NoSeriesGenerated.Reset();
        if NoSeriesGenerated.FindSet() then
            repeat
                Rec := NoSeriesGenerated;
                Rec.Insert();
            until NoSeriesGenerated.Next() = 0;
    end;

    internal procedure GetTempRecord(GenerationId: Integer; var NoSeriesGenerated: Record "PKT No. Series Proposal")
    begin
        NoSeriesGenerated.DeleteAll();
        Rec.Reset();
        Rec.SetRange("Generation Id", GenerationId);
        if Rec.FindSet() then
            repeat
                NoSeriesGenerated.Copy(Rec, false);
                NoSeriesGenerated.Insert();
            until Rec.Next() = 0;
    end;
}
