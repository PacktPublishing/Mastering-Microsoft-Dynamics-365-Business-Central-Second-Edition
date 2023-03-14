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
                    ApplicationArea = all;
                }
                field(ContainerName; Rec."Container Name")
                {
                    ApplicationArea = all;
                }
                field(SharedAccessKey; Rec."Shared Access Key")
                {
                    ApplicationArea = all;
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
    var
        ABSOperationResponse: Codeunit "ABS Operation Response";
        ABSBlobClient: codeunit "ABS Blob Client";
        ABSContainerClient: Codeunit "ABS Container Client";
        Authorization: Interface "Storage Service Authorization";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Response: Codeunit "ABS Operation Response";
        ABSContainerContent: Record "ABS Container Content";
}