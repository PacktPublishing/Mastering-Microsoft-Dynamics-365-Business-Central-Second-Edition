page 50703 "PKT Report Triggers Logs"
{
    Caption = 'PKT Report Triggers Logs';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "PKT Report Triggers Log Table";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Type"; Rec.Type)
                {
                }
                field("Output File Name"; rec."Output File Name")
                {
                }
                field("Output File"; rec."Output File")
                {
                }
                field("Is Text Encoded"; rec."Is Text Encoded")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DownloadFile)
            {
                Caption = 'Download File';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Download;

                trigger OnAction();
                var
                    LogTable: Record "PKT Report Triggers Log Table";
                    InStr: InStream;
                begin
                    LogTable.Get(rec."Entry No.");
                    LogTable.CalcFields("Output File");
                    if LogTable."Output File".HasValue then begin
                        if LogTable."Is Text Encoded" then
                            LogTable."Output File".CreateInStream(InStr, TextEncoding::UTF8)
                        else
                            LogTable."Output File".CreateInStream(InStr);
                        DownloadFromStream(InStr, '', '', '', LogTable."Output File Name");
                    end;
                end;
            }
        }
    }
}
