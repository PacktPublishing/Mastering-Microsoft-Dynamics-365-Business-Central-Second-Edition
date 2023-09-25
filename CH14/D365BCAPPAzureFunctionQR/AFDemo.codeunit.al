codeunit 50101 "SD Azure Functions Demo"
{
    procedure GenerateQRCode(CustomerNo: Code[20]; URL: Text)
    var
        AzureFunction: Codeunit "Azure Functions";
        AzureFunctionResponse: Codeunit "Azure Functions Response";
        AzureFunctionAuthentication: Codeunit "Azure Functions Authentication";
        IAzurefunctionAuthentication: Interface "Azure Functions Authentication";
        FunctionCode, Body, Filename : Text;
        ResultInStream: InStream;
        funcUrl: Label 'https://sdqrcodegenerator.azurewebsites.net/api/QRGenerator';
    begin
        FunctionCode := 'YOUR FUNCTION KEY HERE';
        if URL <> '' then begin
            IAzurefunctionAuthentication := AzureFunctionAuthentication.CreateCodeAuth(funcUrl, FunctionCode);
            Body := '{ "url": "' + URL + '"}';
            AzureFunctionResponse := AzureFunction.SendPostRequest(IAzurefunctionAuthentication, Body, 'application/json');
            if AzureFunctionResponse.IsSuccessful() then begin
                Filename := CustomerNo + '.jpg';
                AzureFunctionResponse.GetResultAsStream(ResultInStream);
                DownloadFromStream(ResultInStream, 'QR CODE', '', '', Filename);
            end;
        end;
    end;
}