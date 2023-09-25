page 50200 "Car List"
{

    PageType = List;
    SourceTable = Car;
    Caption = 'Car List';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ModelNo; Rec.ModelNo)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Brand; Rec.Brand)
                {
                }
                field("Engine Type"; Rec."Engine Type")
                {
                }
                field(Power; Rec.Power)
                {
                }
            }
        }
    }

}

