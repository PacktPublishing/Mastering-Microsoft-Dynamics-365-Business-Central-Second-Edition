tableextension 50200 CUST_PKTVendorQualityExt extends "PKT Vendor Quality"
{
    fields
    {
        field(50200; "CUST_Certification No."; Text[50])
        {
            Caption = 'Certification No.';
            DataClassification = CustomerContent;
        }
    }
}
