tableextension 50100 "PKT CustomerExt" extends Customer
{
    fields
    {
        field(50100; "PKT Customer Category Code"; Code[20])
        {
            Caption = 'Customer Category Code';
            TableRelation = "PKT Customer Category";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CustomerCategory: Record "PKT Customer Category";
                BlockedErr: Label 'This category is blocked.';
            begin
                if CustomerCategory.Get("PKT Customer Category Code") then begin
                    if CustomerCategory.Blocked then
                        Error(BlockedErr);
                end;
            end;
        }
    }

    keys
    {
        key(PKTCustomerCategory; "PKT Customer Category Code")
        {
        }
    }
}