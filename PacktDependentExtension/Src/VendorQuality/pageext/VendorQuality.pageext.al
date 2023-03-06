pageextension 50200 CUST_VendorQualityCardExt extends "PKT Vendor Quality Card"
{
    layout
    {
        addlast(General)
        {
            field("CUST_Certification No."; Rec."CUST_Certification No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
