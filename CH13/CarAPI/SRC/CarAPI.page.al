page 50201 CarAPI
{
    PageType = API;
    Caption = 'Car API';
    APIPublisher = 'sd';
    APIGroup = 'custom';
    APIVersion = 'v1.0';
    EntityName = 'car';
    EntitySetName = 'cars';
    SourceTable = Car;
    DelayedInsert = true;
    ODataKeyFields = systemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(modelno; Rec.ModelNo)
                {
                    Caption = 'modelNo', Locked = true;
                }
                field(description; Rec.Description)
                {
                    Caption = 'description', Locked = true;
                }
                field(brand; Rec.Brand)
                {
                    Caption = 'brand', Locked = true;
                }
                field(engineType; Rec."Engine Type")
                {
                    Caption = 'engineType', Locked = true;
                }
                field(power; Rec.Power)
                {
                    Caption = 'power', Locked = true;
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'systemId', Locked = true;
                }
            }
        }
    }
}
