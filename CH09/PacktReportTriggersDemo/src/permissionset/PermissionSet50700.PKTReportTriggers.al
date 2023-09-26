permissionset 50700 "PKTReportTriggers"
{
    Assignable = true;
    Permissions = tabledata "PKT Report Triggers Log Table" = RIMD,
        tabledata "PKT Report Triggers" = RIMD,
        tabledata "PKT Report Triggers Lines" = RIMD,
        table "PKT Report Triggers Log Table" = X,
        table "PKT Report Triggers" = X,
        table "PKT Report Triggers Lines" = X,
        report "PKT Demo Report Triggers" = X,
        codeunit "PKT Trigger Helper" = X,
        codeunit "PKT Report Triggers Subs." = X,
        page "PKT Report Triggers List" = X;
}