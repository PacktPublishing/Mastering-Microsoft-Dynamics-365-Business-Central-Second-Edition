page 50102 "PKT Vendor Quality Card"
{
    Caption = 'Vendor Quality Card';
    SourceTable = "PKT Vendor Quality";
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
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
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                }
                field("Vendor Activity Description"; Rec."Vendor Activity Description")
                {
                }
                field(Rate; Rec.Rate)
                {
                    Editable = false;
                    Style = Strong;
                }
                field(UpdateDate; Rec.UpdateDate)
                {
                    Editable = false;
                }
            }
            group(Scoring)
            {
                Caption = 'Score';
                field(ScoreItemQuality; Rec.ScoreItemQuality)
                {
                }
                field(ScoreDelivery; Rec.ScoreDelivery)
                {
                }
                field(ScorePackaging; Rec.ScorePackaging)
                {
                }
                field(ScorePricing; Rec.ScorePricing)
                {
                }
            }
            group(Financials)
            {
                Caption = 'Financials';
                field(InvoicedYearN; Rec.InvoicedYearN)
                {
                    Editable = false;
                }
                field(InvoicedYearN1; Rec.InvoicedYearN1)
                {
                    Editable = false;
                }
                field(InvoicedYearN2; Rec.InvoicedYearN2)
                {
                    Editable = false;
                }
                field(DueAmount; Rec.DueAmount)
                {
                    Editable = false;
                    Style = Attention;
                }
                field(AmountNotDue; Rec.AmountNotDue)
                {
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