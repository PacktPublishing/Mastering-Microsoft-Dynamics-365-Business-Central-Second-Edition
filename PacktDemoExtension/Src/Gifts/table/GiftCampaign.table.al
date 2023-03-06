table 50101 "PKT Gift Campaign"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "PKT Gift Campaign List";
    LookupPageId = "PKT Gift Campaign List";
    Caption = 'Gift Campaign';

    fields
    {
        field(1; CustomerCategoryCode; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "PKT Customer Category";
            Caption = 'Customer Category Code';

            trigger OnValidate()
            var
                CustomerCategory: Record "PKT Customer Category";
                ErrNoGifts: Label 'This category is not enabled for Gift Campaigns.';
                ErrBlocked: Label 'This category is blocked.';
            begin
                CustomerCategory.Get(CustomerCategoryCode);
                if CustomerCategory.Blocked then
                    Error(ErrBlocked);
                if not CustomerCategory.FreeGiftsAvailable then
                    Error(ErrNoGifts);
            end;
        }
        field(2; ItemNo; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
            Caption = 'Item No.';
        }
        field(3; StartingDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Date';
        }
        field(4; EndingDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ending Date';
        }
        field(5; MinimumOrderQuantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Order Quantity';
        }
        field(6; GiftQuantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Free Gift Quantity';
        }
        field(7; Inactive; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inactive';
        }

    }

    keys
    {
        key(PK; CustomerCategoryCode, ItemNo, StartingDate, EndingDate)
        {
            Clustered = true;
        }
    }
}