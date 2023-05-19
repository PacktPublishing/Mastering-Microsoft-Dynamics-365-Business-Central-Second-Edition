pageextension 50100 PACKTCustomerListExt extends "Customer List"
{
    actions
    {
        addlast(processing)
        {
            action(PACKTUnblockCustomersSS)
            {
                Caption = 'Unblock all Customers via STARTSESSION';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SessionID: Integer;
                    result: Boolean;
                    SuccessMsg: Label 'Customers unblocked successfully.';
                    ErrorMsg: Label 'Error unblocking customers.';
                begin
                    result := StartSession(SessionID, Codeunit::PACKTBackgroundProcess);
                    if result then
                        Message(SuccessMsg)
                    else
                        Error(ErrorMsg);
                end;
            }
            action(PACKTUnblockCustomersTS)
            {
                Caption = 'Unblock all Customers via TASK SCHEDULER';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    TaskScheduler.CreateTask(Codeunit::PACKTBackgroundProcess, 0, true, Rec.CurrentCompany, CreateDateTime(Today + 1, 0T));
                end;
            }
        }
    }
}