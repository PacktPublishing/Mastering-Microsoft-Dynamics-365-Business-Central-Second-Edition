page 50102 "PKT Vendor Quality Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PKT Vendor Quality";
    Caption = 'Vendor Quality Card';
    InsertAllowed = false;
    AboutTitle = 'About Vendor Quality';
    AboutText = '**Vendor Quality** gives you an overview on how your Vendors performs and how they are ranked internally in your company.';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Activity Description"; Rec."Vendor Activity Description")
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field(UpdateDate; Rec.UpdateDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Scoring)
            {
                Caption = 'Score';
                field(ScoreItemQuality; Rec.ScoreItemQuality)
                {
                    ApplicationArea = All;
                }
                field(ScoreDelivery; Rec.ScoreDelivery)
                {
                    ApplicationArea = All;
                }
                field(ScorePackaging; Rec.ScorePackaging)
                {
                    ApplicationArea = All;
                }
                field(ScorePricing; Rec.ScorePricing)
                {
                    ApplicationArea = All;
                }
            }
            group(Financials)
            {
                Caption = 'Financials';
                field(InvoicedYearN; Rec.InvoicedYearN)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(InvoicedYearN1; Rec.InvoicedYearN1)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(InvoicedYearN2; Rec.InvoicedYearN2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DueAmount; Rec.DueAmount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                }
                field(AmountNotDue; Rec.AmountNotDue)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Insert() then;
    end;

    trigger OnAfterGetRecord()
    var
        VendorQualityMgt: Codeunit "PKT Vendor Quality Mgt";
    begin
        VendorQualityMgt.UpdateVendorQualityStatistics(Rec);
    end;
}