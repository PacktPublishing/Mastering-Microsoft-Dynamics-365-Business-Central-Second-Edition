page 50103 "PKT Gift Campaign List"
{
    Caption = 'Gift Campaigns';
    SourceTable = "PKT Gift Campaign";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    AdditionalSearchTerms = 'promotions, marketing';
    AboutTitle = 'About Gift Campaigns';
    AboutText = 'Here you can define the **Gift Campaigns** for your customers. With a gift campaign you can define promotional periods for your items and define gifts that a customer will receive when ordering some items.';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CustomerCategoryCode; Rec.CustomerCategoryCode)
                {
                }
                field(ItemNo; Rec.ItemNo)
                {
                }
                field(StartingDate; Rec.StartingDate)
                {
                }
                field(EndingDate; Rec.EndingDate)
                {
                }

                field(MinimumOrderQuantity; Rec.MinimumOrderQuantity)
                {
                    Style = Strong;
                }
                field(GiftQuantity; Rec.GiftQuantity)
                {
                    Style = Strong;
                }
                field(Inactive; Rec.Inactive)
                {
                }
            }
        }
    }

    views
    {
        view(ActiveCampaigns)
        {
            Caption = 'Active Gift Campaigns';
            Filters = where(Inactive = const(false));
        }
        view(InactiveCampaigns)
        {
            Caption = 'Inactive Gift Campaigns';
            Filters = where(Inactive = const(true));
        }
    }
}