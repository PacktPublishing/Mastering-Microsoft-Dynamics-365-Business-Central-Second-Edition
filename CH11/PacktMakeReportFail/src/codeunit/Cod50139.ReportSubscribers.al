codeunit 50139 "PKT ReportSubscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Customer - Top 10 List" then
            MakeReportFail();
    end;

    local procedure MakeReportFail()
    var
        UserSetup : Record "User Setup";
        TimeSheetAdminErr: Label 'You must be Time Sheet Admin to run this report.';
        User : Record User;
        Dimensions: Dictionary of [Text, Text];
    begin
        If UserSetup.get(UserId) then begin

            User.SetRange("User Name",UserId);
            User.FindFirst();
            
            Dimensions.Add('UserSecurityId',format(User."User Security ID"));
            Dimensions.Add('IsTimeSheetAdmin',Format(UserSetup."Time Sheet Admin."));

            Session.LogMessage('PKT00001',          //Event id  
                'Checking Time Sheet Admin.',       //Message 
                Verbosity::Normal,                  //Verbosity    
                DataClassification::SystemMetadata, //Data Classification
                TelemetryScope::All,                //Telemetry scope
                Dimensions);                        //Custom Dimensions

            if not UserSetup."Time Sheet Admin." then
                Error(TimeSheetAdminErr);
                
        end;
    end;

}