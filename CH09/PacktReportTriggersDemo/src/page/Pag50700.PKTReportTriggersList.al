page 50700 "PKT Report Triggers List"
{
    Caption = 'PKT Report Triggers List';
    PageType = List;
    SourceTable = "PKT Report Triggers";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TextField; Rec.TextField)
                {
                }
                field(CodeField; Rec.CodeField)
                {
                }
                field(IntegerField; Rec.IntegerField)
                {
                }
                field(BigIntField; Rec.BigIntField)
                {
                }
                field(DecimalFieldNoFormat; Rec.DecimalFieldNoFormat)
                {
                }
                field(DecimailFieldWithFormat; Rec.DecimailFieldWithFormat)
                {
                }
                field(KeyField; Rec.KeyField)
                {
                }
                field(Picture; Rec.Picture)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(DateTime; Rec.DateTime)
                {
                }
                field(Time; Rec.Time)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field(Picture_Url; Rec.Picture_Url)
                {
                }
                field(Text_Url; Rec.Text_Url)
                {
                }
                field(Text_UrlText; Rec.Text_UrlText)
                {
                }
                field(PictureMedia; Rec.PictureMedia)
                {
                }
                field(PictureMediaSet; Rec.PictureMediaSet)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowLogs)
            {
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"PKT Report Triggers Logs");
                end;
            }
        }
        area(Reporting)
        {
            action("Report.SaveAs - Pdf (WordLayout)")
            {
                Caption = 'Report.SaveAs - Pdf (WordLayout)';

                trigger OnAction()
                var
                    TriggerReport: Report "PKT Demo Report Triggers";
                    LogTable: Record "PKT Report Triggers Log Table";
                    OutStr: OutStream;
                begin
                    SetSelection(ReportLayoutType::Word, '');

                    LogTable.DeleteAll();

                    LogTable.Init();
                    LogTable."Type" := 'SaveAs - Pdf (WordLayout)';
                    LogTable."Output File Name" := 'triggerSaveAsFormat.Pdf';
                    LogTable."Output File".CreateOutStream(OutStr);
                    TriggerReport.SaveAs('', ReportFormat::Pdf, OutStr);
                    LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
                    LogTable.Insert(true);
                    Commit();
                end;
            }
            action("Report.SaveAs - Pdf (RDLCLayout)")
            {
                Caption = 'Report.SaveAs - Pdf (RDLCLayout)';

                trigger OnAction()
                var
                    TriggerReport: Report "PKT Demo Report Triggers";
                    LogTable: Record "PKT Report Triggers Log Table";
                    OutStr: OutStream;
                begin
                    SetSelection(ReportLayoutType::RDLC, '');

                    LogTable.DeleteAll();

                    LogTable.Init();
                    LogTable."Type" := 'SaveAs - Pdf (RDLCLayout)';
                    LogTable."Output File Name" := 'triggerSaveAsFormat.Pdf';
                    LogTable."Output File".CreateOutStream(OutStr);
                    TriggerReport.SaveAs('', ReportFormat::Pdf, OutStr);
                    LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
                    LogTable.Insert(true);
                    Commit();
                end;
            }
            action("Report.Run - Implicit Print (Word)")
            {
                Caption = 'Report.Run - Implicit Print (Word)';
                
                trigger OnAction()
                var
                    TriggerReport: Report "PKT Demo Report Triggers";
                    requestPageString: Text;
                    LogTable : Record "PKT Report Triggers Log Table";
                begin
                    LogTable.DeleteAll();

                    SetSelection(ReportLayoutType::Word, 'WordLayout');
                    TriggerReport.UseRequestPage := false;
                    TriggerReport.Run();
                end;
            }
            action("Report.Run - Implicit Print (RDLC)")
            {
                Caption = 'Report.Run - Implicit Print (RDLC)';
                
                trigger OnAction()
                var
                    TriggerReport: Report "PKT Demo Report Triggers";
                    requestPageString: Text;
                    LogTable : Record "PKT Report Triggers Log Table";
                begin
                    LogTable.DeleteAll();
                    
                    SetSelection(ReportLayoutType::RDLC, 'RDLCLayout');
                    TriggerReport.UseRequestPage := false;
                    TriggerReport.Run();
                end;
            }
            action("Report.Print - Word")
            {
                Caption = 'Report.Print - Word';
                
                trigger OnAction()
                var
                    TriggerReport: Report "PKT Demo Report Triggers";
                    LogTable : Record "PKT Report Triggers Log Table";
                begin
                    LogTable.DeleteAll();

                    SetSelection(ReportLayoutType::Word, 'WordLayout');
                    TriggerReport.Print('');  // This will hit the printer event and save a file in the temp folder.
                end;
            }
            action("Report.Print - RDLC")
            {
                Caption = 'Report.Print - RDLC';                
                trigger OnAction()
                var
                    TriggerReport: Report "PKT Demo Report Triggers";
                    LogTable : Record "PKT Report Triggers Log Table";
                begin
                    LogTable.DeleteAll();

                    SetSelection(ReportLayoutType::RDLC, 'RDLCLayout');
                    TriggerReport.Print('');  // This will hit the printer event and save a file in the temp folder.
                end;
            }
            action("RunObject")
            {
                Caption = 'RunObject';
                ApplicationArea = All;
                RunObject = report "PKT Demo Report Triggers";
            }
            action("Reset Layout Selection")
            {
                Caption = 'Reset Layout Selction';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ClearSelection();
                end;
            }

        }
    }

    procedure SetSelection(layoutFormat: ReportLayoutType; Name: Text)
    var
        ReportLayoutSelection: Record "Tenant Report Layout Selection";
        ReportLayout: Record "Report Layout List";
    begin
        ReportLayout.SetFilter(ReportLayout."Report ID", format(Report::"PKT Demo Report Triggers"));
        ReportLayout.SetFilter(ReportLayout."Layout Format", format(layoutFormat));
        if (Name <> '') then
            ReportLayout.SetFilter(ReportLayout.Name, Name);

        if not ReportLayout.FindSet() then
            error('No layout of type %1', layoutFormat);

        ReportLayoutSelection.Init();
        ReportLayoutSelection."Report ID" := ReportLayout."Report ID";
        ReportLayoutSelection."App ID" := ReportLayout."Application ID";
        ReportLayoutSelection."Layout Name" := ReportLayout.Name;

        if not ReportLayoutSelection.Insert(false) then
            ReportLayoutSelection.Modify(false);
    end;

    procedure ClearSelection()
    var
        ReportLayoutSelection: Record "Tenant Report Layout Selection";
    begin
        ReportLayoutSelection.Init();
        ReportLayoutSelection."Report ID" := Report::"PKT Demo Report Triggers";
        ReportLayoutSelection.DeleteAll();
    end;

}

