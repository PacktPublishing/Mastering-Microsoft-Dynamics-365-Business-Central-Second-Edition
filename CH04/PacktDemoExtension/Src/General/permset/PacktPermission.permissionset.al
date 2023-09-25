permissionset 50100 "PKT Packt Permission"
{
    Caption = 'PACKT Permissions';
    Assignable = true;
    Permissions = tabledata "PKT Customer Category" = RIMD,
        tabledata "PKT Gift Campaign" = RIMD,
        tabledata "PKT Packt Setup" = RIMD,
        tabledata "PKT Vendor Quality" = RIMD,
        table "PKT Customer Category" = X,
        table "PKT Gift Campaign" = X,
        table "PKT Packt Setup" = X,
        table "PKT Vendor Quality" = X,
        report "Item Ledger Entry Analysis" = X,
        codeunit "PKT Customer Category Mgt" = X,
        codeunit "PKT Gift Management" = X,
        codeunit "PKT Vendor Quality Mgt" = X,
        page "PKT Customer Category Card" = X,
        page "PKT Customer Category List" = X,
        page "PKT Gift Campaign List" = X,
        page "PKT Packt Setup" = X,
        page "PKT Vendor Quality Card" = X;
}

permissionset 50101 "PKT Sales Agent"
{
    Assignable = true;
    Caption = 'Sales Agent Base';

    Permissions =
        tabledata Customer = RIMD,
        tabledata "Payment Terms" = RMD,
        tabledata Currency = RM,
        tabledata "Sales Header" = RIM,
        tabledata "Sales Line" = RIMD;
}

permissionset 50102 "PKT Sales Agent Adv"
{
    Assignable = true;
    Caption = 'Advanced Sales Agent';
    IncludedPermissionSets = "PKT Sales Agent", "D365 CUSTOMER, EDIT", "D365 VENDOR, EDIT";

    Permissions =
        tabledata "Purchase Header" = RIM,
        tabledata "Purchase Line" = RIMD,
        codeunit AccSchedManagement = X;
}

permissionset 50103 "PKT Sales Agent Jnr"
{
    Assignable = true;
    Caption = 'Junior Sales Agent';
    IncludedPermissionSets = "PKT Sales Agent Adv";
    ExcludedPermissionSets = "D365 VENDOR, EDIT";
}