codeunit 61120 "PKT No. Series Copilot Install"
{
    Subtype = Install;

    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
    end;

    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        EnvironmentInformation: Codeunit "Environment Information";
        LearnMoreUrlTxt: Label 'https://www.demiliani.com', Locked = true;
    begin
        if EnvironmentInformation.IsSaaS() then
            if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"PKT No. Series Copilot") then
                CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"PKT No. Series Copilot", LearnMoreUrlTxt);
    end;
}