pageextension 50113 "PKT ItemLedgerEntriesExt" extends "Item Ledger Entries"
{
    actions
    {
        addlast(Creation)
        {
            action(PKTCollectALProfilerTrace)
            {
                Caption='Collect Profiler Trace';
                Image=ProfileCalendar;

                Promoted=true;
                PromotedIsBig=true;
                PromotedCategory=New;
                ApplicationArea = All;
                
                trigger OnAction()
                var
                    ProfilerManagement : Codeunit "PKT Profiler Management";
                begin
                    ProfilerManagement.Start();
                end;
            }
        }
    }
}