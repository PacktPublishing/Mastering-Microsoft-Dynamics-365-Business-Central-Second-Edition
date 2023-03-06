tableextension 50200 CUST_VendorQualityExt extends "PKT Vendor Quality"
{
    fields
    {
        field(50120; "CUST_Certification No."; Text[50])
        {
            Caption = 'Certification No.';
            DataClassification = CustomerContent;
        }
    }
}
