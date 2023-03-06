table 50103 "PKT Packt Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Packt Extension Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Minimum Accepted Vendor Rate"; Decimal)
        {
            Caption = 'Minimum Accepted Vendor Rate for Purchases';
            DataClassification = CustomerContent;
        }
        field(3; "Gift Tolerance Qty"; Decimal)
        {
            Caption = 'Gift Tolerance Quantity for Sales';
            DataClassification = CustomerContent;
        }
        field(4; "Default Charge (Item)"; Code[20])
        {
            Caption = 'Default Charge (Item)';
            DataClassification = CustomerContent;
            TableRelation = "Item Charge";
        }
        field(10; "Shipmt Commission Calc. Method"; enum "PKT Shipm. Comm. Calc Method")
        {
            Caption = 'Shipment Commission Calc. Method';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}