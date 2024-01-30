pageextension 61120 "PKT No. Series Ext" extends "No. Series"
{
    actions
    {
        addfirst(Promoted)
        {
            actionref("PKT Generate_Promoted"; "PKT Generate") { }
        }
        addlast("&Series")
        {
            action("PKT Generate")
            {
                Caption = 'Generate';
                ToolTip = 'Generate No. Series using Copilot';
                Image = Sparkle;
                ApplicationArea = All;
                trigger OnAction()
                var
                    NoSeriesCopilot: Page "PKT No. Series Proposal";
                begin
                    NoSeriesCopilot.LookupMode := true;
                    if NoSeriesCopilot.RunModal = Action::LookupOK then
                        CurrPage.Update();
                end;
            }
        }
    }
}