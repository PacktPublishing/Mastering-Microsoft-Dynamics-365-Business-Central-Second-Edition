pageextension 50201 CUST_PKTPacktSetupExt extends "PKT Packt Setup"
{
    layout
    {
        addlast(General)
        {
            field("CUST_Default Charge"; Rec."CUST_Default Charge")
            {
                ApplicationArea = All;
            }
        }
    }
}