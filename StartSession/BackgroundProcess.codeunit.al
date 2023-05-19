codeunit 50100 PACKTBackgroundProcess
{
    trigger OnRun()
    begin
        UnblockCustomers();
    end;

    local procedure UnblockCustomers()
    var
        Customer: Record Customer;
    begin
        if Customer.FindSet() then
            repeat
                Customer.Validate(Blocked, Customer.Blocked::" ");
                Customer.Modify();
            until Customer.Next() = 0;
    end;

}