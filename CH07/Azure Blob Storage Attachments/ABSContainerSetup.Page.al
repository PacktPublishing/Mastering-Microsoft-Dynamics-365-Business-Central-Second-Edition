page 50100 "SD ABS Container Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SD ABS Container Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(AccountName; Rec."Account Name")
                {
                }
                field(ContainerName; Rec."Container Name")
                {
                }
                field(SharedAccessKey; Rec."Shared Access Key")
                {
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

}