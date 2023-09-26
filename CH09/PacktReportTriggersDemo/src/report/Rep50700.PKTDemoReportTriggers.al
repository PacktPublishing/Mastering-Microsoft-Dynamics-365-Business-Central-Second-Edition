report 50700 "PKT Demo Report Triggers"
{
    Caption = 'PKT Demo Report Triggers';
    DefaultRenderingLayout = "RDLCLayout";
    WordMergeDataItem = ReportTriggers;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ReportTriggers; "PKT Report Triggers")
        {
            column(TextField_ReportTriggers; ReportTriggers.TextField)
            {
            }
            column(CodeField_ReportTriggers; ReportTriggers.CodeField)
            {
            }
            column(IntegerField_ReportTriggers; ReportTriggers.IntegerField)
            {
            }
            column(BigIntField_ReportTriggers; ReportTriggers.BigIntField)
            {
            }
            column(DecimalFieldNoFormat_ReportTriggers; ReportTriggers.DecimalFieldNoFormat)
            {
            }
            column(DecimailFieldWithFormat_ReportTriggers; ReportTriggers.DecimailFieldWithFormat)
            {
            }
            column(KeyField_ReportTriggers; ReportTriggers.KeyField)
            {
            }
            column(Picture_ReportTriggers; ReportTriggers.Picture)
            {
            }
            column(Date_ReportTriggers; ReportTriggers.Date)
            {
            }
            column(DateTime_ReportTriggers; ReportTriggers.DateTime)
            {
            }
            column(Time_ReportTriggers; ReportTriggers.Time)
            {
            }
            column(Duration_ReportTriggers; ReportTriggers.Duration)
            {
            }
            column(PictureUrl_ReportTriggers; ReportTriggers.Picture_Url)
            {
            }
            column(TextUrl_ReportTriggers; ReportTriggers.Text_Url)
            {
            }
            column(TextUrlText_ReportTriggers; ReportTriggers.Text_UrlText)
            {
            }
            column(PictureMedia_ReportTriggers; ReportTriggers.PictureMedia)
            {
            }
            column(PictureMediaSet_ReportTriggers; ReportTriggers.PictureMediaSet)
            {
            }
            dataitem(ReportTriggersLines; "PKT Report Triggers Lines")
            {
                DataItemLink = ParentReportItem = FIELD(KeyField);
                column(KeyField_ReportTriggersLines; ReportTriggersLines.KeyField)
                {
                }
                column(ItemLine1_ReportTriggersLines; ReportTriggersLines.ItemLine1)
                {
                }
                column(ItemLine2_ReportTriggersLines; ReportTriggersLines.ItemLine2)
                {
                }
                column(ParentReportItem_ReportTriggersLines; ReportTriggersLines.ParentReportItem)
                {
                }
                column(ItemDecimal_ReportTriggersLines; ReportTriggersLines.ItemDecimal)
                {
                }
                column(ItemPicture_ReportTriggersLines; ReportTriggersLines.ItemPicture)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TriggerHelper.Add('ReportTriggersLines - OnAfterGetRecord ' + FORMAT(ReportTriggersLines.KeyField));
                end;

                trigger OnPostDataItem()
                begin
                    TriggerHelper.Add('ReportTriggersLines - OnPreDataItem');
                end;

                trigger OnPreDataItem()
                begin
                    TriggerHelper.Add('ReportTriggersLines - OnPreDataItem');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TriggerHelper.Add('ReportTriggers - OnAfterGetRecord ' + FORMAT(ReportTriggers.KeyField));
            end;

            trigger OnPostDataItem()
            begin
                TriggerHelper.Add('ReportTriggers - OnPostDataItem');
            end;

            trigger OnPreDataItem()
            begin
                TriggerHelper.Add('ReportTriggers - OnPreDataItem');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        trigger OnAfterGetCurrRecord()
        begin
            TriggerHelper.Add('OnAfterGetCurrRecord');
        end;

        trigger OnAfterGetRecord()
        begin
            TriggerHelper.Add('OnAfterGetRecord');
        end;

        trigger OnClosePage()
        begin
            TriggerHelper.Add('OnClosePage');
        end;

        trigger OnDeleteRecord(): Boolean
        begin
            TriggerHelper.Add('OnDeleteRecord');
        end;

        trigger OnFindRecord(Which: Text): Boolean
        begin
            TriggerHelper.Add('OnFindRecord');
        end;

        trigger OnInit()
        begin
            TriggerHelper.Add('OnInit');
        end;

        trigger OnInsertRecord(BelowxRec: Boolean): Boolean
        begin
            TriggerHelper.Add('OnInsertRecord');
        end;

        trigger OnModifyRecord(): Boolean
        begin
            TriggerHelper.Add('OnModifyRecord');
        end;

        trigger OnNewRecord(BelowxRec: Boolean)
        begin
            TriggerHelper.Add('OnNewRecord');
        end;

        trigger OnNextRecord(Steps: Integer): Integer
        begin
            TriggerHelper.Add('OnNextRecord');
        end;

        trigger OnOpenPage()
        begin
            TriggerHelper.Add('OnOpenPage');
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            TriggerHelper.Add('OnQueryClosePage');
        end;
    }

    rendering
    {
        layout("RDLCLayout")
        {
            Type = RDLC;
            LayoutFile = './ReportTriggers.rdl';
            Caption = 'RDLC Layout Caption';
            Summary = 'RDLC Layout Summary';
        }
        layout("WordLayout")
        {
            Type = Word;
            LayoutFile = './ReportTriggers.docx';
            Caption = 'Word Layout Caption';
            Summary = 'Word Layout Summary';
        }
        layout("ExcelLayout")
        {
            Type = Excel;
            LayoutFile = './ReportTriggers.xlsx';
            Caption = 'Excel Layout Caption';
            Summary = 'Excel Layout Summary';
        }
    }

    trigger OnInitReport()
    begin
        TriggerHelper.Init();
        TriggerHelper.Add('OnInitReport');
    end;

    trigger OnPostReport()
    begin
        TriggerHelper.Add('OnPostReport');
        TriggerHelper.Save('EventSequence.txt');
    end;

    trigger OnPreReport()
    begin
        TriggerHelper.Add('OnPreReport');
    end;

    var
        TriggerHelper: Codeunit "PKT Trigger Helper";
}

