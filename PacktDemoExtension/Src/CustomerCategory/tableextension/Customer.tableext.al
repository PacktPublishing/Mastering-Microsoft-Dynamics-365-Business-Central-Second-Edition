tableextension 50100 "PKT CustomerExt" extends Customer
{
    fields
    {
        field(50100; "PKT Customer Category Code"; Code[20])
        {
            TableRelation = "PKT Customer Category";
            Caption = 'Customer Category Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CustomerCategory: Record "PKT Customer Category";
                ErrBlocked: Label 'This category is blocked.';
            begin
                if CustomerCategory.Get("PKT Customer Category Code") then begin
                    if CustomerCategory.Blocked then
                        Error(ErrBlocked);
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