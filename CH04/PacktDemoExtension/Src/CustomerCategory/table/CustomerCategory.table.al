
table 50100 "PKT Customer Category"
{
    Caption = 'Customer Category';
    DrillDownPageId = "PKT Customer Category List";
    LookupPageId = "PKT Customer Category List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Default; Boolean)
        {
            Caption = 'Default';
        }
        field(4; EnableNewsletter; Enum "PKT NewsletterType")
        {
            Caption = 'Enable Newsletter';
            DataClassification = CustomerContent;
        }
        field(5; FreeGiftsAvailable; Boolean)
        {
            Caption = 'Free Gifts Available';
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(10; TotalCustomersForCategory; Integer)
        {
            Caption = 'No. of associated customers';
            FieldClass = FlowField;
            CalcFormula = count(Customer where("PKT Customer Category Code" = field(Code)));
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

