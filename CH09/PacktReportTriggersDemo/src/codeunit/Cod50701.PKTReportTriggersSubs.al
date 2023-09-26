codeunit 50701 "PKT Report Triggers Subs."
{
    EventSubscriberInstance = StaticAutomatic;

    trigger OnRun()
    begin
        Init();
    end;

    var
        TriggerHelper: Codeunit "PKT Trigger Helper";
        TempFolderPath: Text;
        DefaultPrinterName: Label 'ReportTriggersPrinter';
        Initialized: Boolean;

    procedure Init()
    begin
        if Initialized then
            exit;

        SetPrinterSelection(Report::"PKT Demo Report Triggers");

        Initialized := true;
    end;

    procedure SanitizeFilename(FileName: Text): Text
    begin
        FileName := FileName.Replace('/', '_');
        FileName := FileName.Replace('\', '_');
        exit(FileName);
    end;

    procedure SetPrinterSelection(ReportId: Integer)
    var
        PrinterSelection: Record "Printer Selection";
        UserId: Text;
    begin
        UserId := Database.UserId;
        if PrinterSelection.Get(UserId, ReportId) then PrinterSelection.Delete();
        PrinterSelection.Init();
        PrinterSelection."User ID" := UserId;
        PrinterSelection."Report ID" := ReportId;
        PrinterSelection."Printer Name" := DefaultPrinterName;
        PrinterSelection.Insert();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterGetPrinterName', '', true, true)]
    local procedure OnAfterGetPrinterName(ReportID: Integer; var PrinterName: Text[250]; PrinterSelection: Record "Printer Selection")
    begin
        TriggerHelper.Add('OnAfterGetPrinterName');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterHasCustomLayout', '', true, true)]
    local procedure OnAfterHasCustomLayout(ObjectType: Option "Report","Page"; ObjectID: Integer; var LayoutType: Option "None",RDLC,Word,Excel,Custom)
    begin
        TriggerHelper.Add('OnAfterHasCustomLayout');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterGetPaperTrayForReport', '', true, true)]
    local procedure OnAfterGetPaperTrayForReport(ReportID: Integer; var FirstPage: Integer; var DefaultPage: Integer; var LastPage: Integer)
    begin
        TriggerHelper.Add('OnAfterGetPaperTrayForReport');

        if ReportID = Report::"PKT Demo Report Triggers" then
            DefaultPage := 10; // LargeFormat
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', true, true)]
    local procedure OnAfterSubstituteReport(ReportId: Integer; RunMode: Option Normal,ParametersOnly,Execute,Print,SaveAs,RunModal; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    begin
        TriggerHelper.Add('OnAfterSubstituteReport');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterDocumentReady', '', true, true)]
    local procedure OnAfterDocumentReady(ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var TargetStream: OutStream; var Success: Boolean)
    var
        ReportIntentJson: JsonToken;
        ReportIntentTxt: Text;
        JsonText: Text;
        LogTable: Record "PKT Report Triggers Log Table";
        OutStr: OutStream;
        mimeType: Text;
    begin
        TriggerHelper.Add('OnAfterDocumentReady');

        // Lock this subscriber to the test report "PKT Report Triggers" to prevent side effects in the running app.
        if ObjectId <> Report::"PKT Demo Report Triggers" then
            exit;

        if Success = true then
            exit;

        Init();

        // Save the report payload in a Log table.
        ObjectPayload.WriteTo(JsonText);

        LogTable.Init();
        LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
        LogTable."Type" := 'JsonFile';
        LogTable."Output File Name" := TempFolderPath + 'OnAfterDocumentReady.json';
        LogTable."Is Text Encoded" := true;
        LogTable."Output File".CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(JsonText);
        LogTable.Insert(true);
        Commit();

        ObjectPayload.Get('intent', ReportIntentJson);
        ReportIntentTxt := ReportIntentJson.AsValue().AsText();

        if GuiAllowed then begin
            case ReportIntentTxt of
                'Save':
                    message('OnAfterDocumentReady intent: SAVE something');
                'Download':
                    message('OnAfterDocumentReady intent: DOWNLOAD something');
                'Print':
                    message('OnAfterDocumentReady intent: PRINT something');
            end;
        end;

        // do something on the document stream and write it back to the serverr.
        CopyStream(TargetStream, DocumentStream);
        Success := true; // true means that the server should handle the data in the output stream.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterIntermediateDocumentReady', '', true, true)]
    local procedure OnAfterIntermediateDocumentReady(ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var TargetStream: OutStream; var Success: Boolean)
    var
        ReportIntentJson: JsonToken;
        ReportIntentTxt: Text;
        JsonText: Text;
        LogTable: Record "PKT Report Triggers Log Table";
        OutStr: OutStream;
        mimeType: Text;
    begin
        TriggerHelper.Add('OnAfterIntermediateDocumentReady');

        // Lock this subscriber to the test report "PKT Report Triggers" to prevent side effects in the running app.
        if ObjectId <> Report::"PKT Demo Report Triggers" then
            exit;

        if Success = true then
            exit;

        Init();

        // Save the report payload in a text file.
        ObjectPayload.WriteTo(JsonText);

        LogTable.Init();
        LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
        LogTable."Type" := 'JsonFile';
        LogTable."Output File Name" := TempFolderPath + 'OnAfterIntermediateDocumentReady.json';
        LogTable."Is Text Encoded" := true;
        LogTable."Output File".CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(JsonText);
        LogTable.Insert(true);
        Commit();

        ObjectPayload.Get('intent', ReportIntentJson);
        ReportIntentTxt := ReportIntentJson.AsValue().AsText();

        if GuiAllowed then begin
            case ReportIntentTxt of
                'Save':
                    message('OnAfterIntermediateDocumentReady intent: SAVE something');
                'Download':
                    message('OnAfterIntermediateDocumentReady intent: DOWNLOAD something');
                'Print':
                    message('OnAfterIntermediateDocumentReady intent: PRINT something');
            end;
        end;

        // do something on the document stream and write it back to the serverr.
        CopyStream(TargetStream, DocumentStream);
        Success := true; // true means that the server should handle the data in the output stream.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterDocumentDownload', '', true, true)]
    local procedure OnAfterDocumentDownload(ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var Success: Boolean)
    var
        JsonText: Text;
        LogTable: Record "PKT Report Triggers Log Table";
        OutStr: OutStream;
        ObjectName: JsonToken;
        DocumentTypeParts: List of [Text];
        DocumentType: JsonToken;
        ReportIntentJson: JsonToken;
        ReportIntentTxt: Text;
        FileContent: OutStream;
        FilePath: Text;
        FileName: Text;
        Extension: Text;
    begin
        TriggerHelper.Add('OnAfterDocumentDownload');

        // Lock this subscriber to the test report "PKT Report Triggers" to prevent side effects in the running app.
        if ObjectId <> Report::"PKT Demo Report Triggers" then
            exit;

        if Success = true then
            exit;

        Init();
        ObjectPayload.WriteTo(JsonText);

        LogTable.Init();
        LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
        LogTable."Type" := 'JsonFile';
        LogTable."Output File Name" := TempFolderPath + 'OnAfterDocumentDownload.json';
        LogTable."Is Text Encoded" := true;
        LogTable."Output File".CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(JsonText);
        LogTable.Insert(true);
        Commit();

        ObjectPayload.Get('objectname', ObjectName);
        FileName := SanitizeFilename(ObjectName.AsValue().AsText());

        ObjectPayload.Get('documenttype', DocumentType);
        DocumentTypeParts := DocumentType.AsValue().AsText().Split('/');
        Extension := DocumentTypeParts.Get(DocumentTypeParts.Count);

        ObjectPayload.Get('intent', ReportIntentJson);
        ReportIntentTxt := ReportIntentJson.AsValue().AsText();

        if GuiAllowed then begin
            case ReportIntentTxt of
                'Save':
                    message('OnAfterDocumentDownload intent: SAVE something');
                'Download':
                    message('OnAfterDocumentDownload intent: DOWNLOAD something');
                'Print':
                    message('OnAfterDocumentDownload intent: PRINT something');
            end;
        end;

        FilePath := TempFolderPath + 'DownLoad - ' + FileName + '.' + Extension;

        LogTable.Init();
        LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
        LogTable."Type" := 'FileHandler-OnAfterDocumentDownload';
        LogTable."Output File Name" := FilePath;
        LogTable."Output File".CreateOutStream(FileContent);
        CopyStream(FileContent, DocumentStream);
        LogTable.Insert(true);
        Commit();

        Success := false; // Set this to true if you don't want a download to client
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", 'SetupPrinters', '', true, true)]
    procedure SetupPrinters(var Printers: Dictionary of [Text[250], JsonObject]);
    var
        Payload1: JsonObject;
        PaperTrays1: JsonArray;
        PaperTray1: JsonObject;
        PaperTray2: JsonObject;
        PaperTray3: JsonObject;
        PaperTray4: JsonObject;
    begin
        TriggerHelper.Add('SetupPrinters');

        // printer #1
        PaperTray1.Add('papersourcekind', 'Upper');
        PaperTray1.Add('paperkind', 'A4');
        PaperTray1.Add('landscape', true);

        PaperTray2.Add('papersourcekind', 'Lower');
        PaperTray2.Add('paperkind', 'Letter');
        PaperTray2.Add('landscape', false);

        PaperTray3.Add('papersourcekind', 'LargeFormat');
        PaperTray3.Add('paperkind', 'CSheet');

        PaperTray4.Add('papersourcekind', 'LargeCapacity');
        PaperTray4.Add('paperkind', 'A4');
        PaperTray4.Add('landscape', false);

        PaperTrays1.Add(PaperTray1);
        PaperTrays1.Add(PaperTray2);
        PaperTrays1.Add(PaperTray3);
        PaperTrays1.Add(PaperTray4);

        Payload1.Add('version', 1);
        Payload1.Add('papertrays', PaperTrays1);
        Payload1.Add('defaultcopies', 7);
        Payload1.Add('color', true);
        Payload1.Add('duplex', true);

        Printers.Add(DefaultPrinterName, Payload1);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", 'OnDocumentPrintReady', '', true, true)]
    procedure OnDocumentPrintReady(ObjectType: Option "Report","Page"; ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var Success: Boolean);
    var
        ObjectName: JsonToken;
        DocumentTypeParts: List of [Text];
        DocumentType: JsonToken;
        FileContent: OutStream;
        FilePath: Text;
        FileName: Text;
        Extension: Text;
        PrinterDefaultCopies: JsonToken;
        PrinterColor: JsonToken;
        PrinterDuplex: JsonToken;
        JsonText: Text;
        LogTable: Record "PKT Report Triggers Log Table";
        OutStr: OutStream;
    begin
        TriggerHelper.Add('OnDocumentPrintReady');

        // Lock this subscriber to the test report "PKT Report Triggers" to prevent side effects in the running app.
        if ObjectId <> Report::"PKT Demo Report Triggers" then
            exit;

        if Success = true then
            exit;

        Init();

        ObjectPayload.WriteTo(JsonText);

        LogTable.Init();
        LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
        LogTable."Type" := 'JsonFile';
        LogTable."Output File Name" := TempFolderPath + 'OnDocumentPrintReady.json';
        LogTable."Is Text Encoded" := true;
        LogTable."Output File".CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(JsonText);
        LogTable.Insert(true);
        Commit();

        if ObjectType = ObjectType::Report then begin
            ObjectPayload.Get('objectname', ObjectName);
            FileName := SanitizeFilename(ObjectName.AsValue().AsText());

            ObjectPayload.Get('documenttype', DocumentType);
            DocumentTypeParts := DocumentType.AsValue().AsText().Split('/');
            Extension := DocumentTypeParts.Get(DocumentTypeParts.Count);

            FilePath := TempFolderPath + FileName + '.' + Extension;

            LogTable.Init();
            LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
            LogTable."Type" := 'FileHandler-OnDocumentPrintReady';
            LogTable."Output File Name" := FilePath;
            LogTable."Output File".CreateOutStream(FileContent);
            CopyStream(FileContent, DocumentStream);
            LogTable.Insert(true);
            Commit();

            Success := false; // Set this one to true if the client download should be discarded
            exit;
        end;

        Success := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", ApplicationReportMergeStrategy, '', true, true)]
    local procedure OnApplicationReportMergeStrategy(ObjectId: Integer; LayoutCode: Text; var InApplication: boolean)
    begin
        TriggerHelper.Add('OnApplicationReportMergeStrategy');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", CustomDocumentMergerEx, '', true, true)]
    local procedure CustomDocumentMergerEx(ObjectID: Integer; ReportAction: Option SaveAsPdf,SaveAsWord,SaveAsExcel,Preview,Print,SaveAsHtml; ObjectPayload: JsonObject; XmlData: InStream; LayoutData: InStream; var DocumentStream: OutStream; var Success: Boolean) 
    begin
        TriggerHelper.Add('CustomDocumentMergerEx');

        // Lock this subscriber to the test report "PKT Report Triggers" to prevent side effects in the running app.
        if ObjectId <> Report::"PKT Demo Report Triggers" then
            exit;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", CustomDocumentMerger, '', true, true)]
    local procedure OnCustomDocumentMerger(ObjectID: Integer; ReportAction: Option SaveAsPdf,SaveAsWord,SaveAsExcel,Preview,Print,SaveAsHtml; XmlData: InStream; LayoutData: InStream; var DocumentStream: OutStream)
    var
        ReportingTriggers : Codeunit "Reporting Triggers";
        fsfsd : Codeunit "Custom Layout Reporting";
    begin
        TriggerHelper.Add('OnCustomDocumentMerger');

        // Lock this subscriber to the test report "PKT Report Triggers" to prevent side effects in the running app.
        if ObjectId <> Report::"PKT Demo Report Triggers" then
            exit;
    end;
    
}