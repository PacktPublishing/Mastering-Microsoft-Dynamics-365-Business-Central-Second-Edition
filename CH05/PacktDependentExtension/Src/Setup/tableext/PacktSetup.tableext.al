tableextension 50201 CUST_PKTPacktSetupExt extends "PKT Packt Setup"
{
    fields
    {
        field(50200; "CUST_Default Charge"; Decimal)
        {
            Caption = 'Default Charge';
            DataClassification = CustomerContent;
        }
    }
}