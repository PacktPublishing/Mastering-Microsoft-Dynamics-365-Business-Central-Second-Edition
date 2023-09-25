pageextension 50101 "PKT VendorCardExt" extends "Vendor Card"
{
    actions
    {
        addafter("Co&mments")
        {
            action("PKT Quality Classification")
            {
                Caption = 'Quality Classification';
                ApplicationArea = All;
                Image = QualificationOverview;
                RunObject = Page "PKT Vendor Quality Card";
                RunPageLink = "Vendor No." = field("No.");
            }
        }
        addlast(Promoted)
        {
            group(PKTQuality)
            {
                Caption = 'Vendor Quality';
                actionref(PKTQualityClassification; "PKT Quality Classification")
                {
                }
            }
        }
    }
}



