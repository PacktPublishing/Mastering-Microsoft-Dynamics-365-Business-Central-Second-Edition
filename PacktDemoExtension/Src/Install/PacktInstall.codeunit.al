codeunit 50105 "PKT Packt Install"
{
    Subtype = Install;
    trigger OnInstallAppPerCompany();
    var
        CustomerCategory: Record "PKT Customer Category";
        PacktSetup: Record "PKT Packt Setup";
    begin
        if CustomerCategory.IsEmpty() then
            InsertDefaultCustomerCategory();
        if PacktSetup.IsEmpty() then
            InsertDefaultSetup();
    end;

    // Insert the GOLD, SILVER, BRONZE reward levels
    local procedure InsertDefaultCustomerCategory();
    begin
        InsertCustomerCategory('DEFAULT', 'Default', true);
        InsertCustomerCategory('GOLD', 'Gold customers', false);
        InsertCustomerCategory('SILVER', 'Silver customers', false);
        InsertCustomerCategory('BRONZE', 'Bronze customers', false);
    end;

    // Create and insert a Customer Category record
    local procedure InsertCustomerCategory(ID: Code[30]; Description: Text[250]; Default: Boolean);
    var
        CustomerCategory: Record "PKT Customer Category";
    begin
        CustomerCategory.Init();
        CustomerCategory.Code := ID;
        CustomerCategory.Description := Description;
        CustomerCategory.Default := Default;
        CustomerCategory.Insert();
    end;

    local procedure InsertDefaultSetup()
    var
        PacktSetup: Record "PKT Packt Setup";
    begin
        PacktSetup.Init();
        PacktSetup."Minimum Accepted Vendor Rate" := 6;
        PacktSetup."Gift Tolerance Qty" := 2;
        PacktSetup.Insert();
    end;
}


// codeunit 50104 "PKT Packt Upgrade"
// {
//     Subtype = Upgrade;

//     trigger OnUpgradePerCompany()
//     var
//         myInt: Integer;
//     begin

//     end;

//     local procedure MoveField()
//     var
//         from: Record FromTable;
//         to: Record ToTable;
//     begin
//         if from.Find() then
//             repeat
// to.Get(from.RecordId);
// to.IntField := from.IntField;
// to.SmallCodeField := from.SmallCodeField;
// to.Modify();
//             until from.Next() = 0
//     end;
// }
