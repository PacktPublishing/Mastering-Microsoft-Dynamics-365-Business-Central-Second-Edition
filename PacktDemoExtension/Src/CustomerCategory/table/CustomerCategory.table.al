
table 50100 "PKT Customer Category"
{
    DrillDownPageId = "PKT Customer Category List";
    LookupPageId = "PKT Customer Category List";
    Caption = 'Customer Category';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Default; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Default';
        }

        field(4; EnableNewsletter; Enum "PKT NewsletterType")
        {
            Caption = 'Enable Newsletter';
            DataClassification = CustomerContent;
        }

        field(5; FreeGiftsAvailable; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Free Gifts Available';
        }

        field(6; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }

        field(10; TotalCustomersForCategory; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("PKT Customer Category Code" = field(Code)));
            Caption = 'No. of associated customers';
        }

    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(K2; Description)
        {
            Unique = true;
        }
    }

    procedure GetSalesAmount(): Decimal
    var
        CustomerCategoryMgt: Codeunit "PKT Customer Category Mgt";
    begin
        exit(CustomerCategoryMgt.GetSalesAmount(Rec.Code));
    end;

}

