codeunit 61121 "PKT No. Series Copilot Impl."
{
    procedure Generate(var GenerationId: Record "Name/Value Buffer"; var NoSeriesGenerated: Record "PKT No. Series Proposal"; InputText: Text)
    var
        SystemPromptTxt: Text;
        CompletePromptTokenCount: Integer;
        Completion: Text;
    begin
        SystemPromptTxt := GetSystemPrompt();

        Completion := GenerateNoSeries(SystemPromptTxt, InputText);
        if CheckIfValidCompletion(Completion) then begin
            SaveGenerationHistory(GenerationId, InputText);
            CreateNoSeries(GenerationId, NoSeriesGenerated, Completion);
        end;
    end;

    [NonDebuggable]
    internal procedure GenerateNoSeries(var SystemPromptTxt: Text; InputText: Text): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAi";
        AOAIDeployments: Codeunit "AOAI Deployments";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        CompletionAnswerTxt: Text;
    begin
        if not AzureOpenAI.IsEnabled(Enum::"Copilot Capability"::"PKT No. Series Copilot") then
            exit;

        AzureOpenAI.SetAuthorization(Enum::"AOAI Model Type"::"Chat Completions", GetEndpoint(), GetDeployment(), GetSecret());
        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"PKT No. Series Copilot");
        AOAIChatCompletionParams.SetMaxTokens(MaxOutputTokens());
        AOAIChatCompletionParams.SetTemperature(0);
        AOAIChatMessages.AddSystemMessage(SystemPromptTxt);
        AOAIChatMessages.AddUserMessage(InputText);
        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);
        if AOAIOperationResponse.IsSuccess() then
            CompletionAnswerTxt := AOAIChatMessages.GetLastMessage()
        else
            Error(AOAIOperationResponse.GetError());

        exit(CompletionAnswerTxt);
    end;

    local procedure GetSystemPrompt(): Text
    var
        SystemPrompt: TextBuilder;
    begin
        SystemPrompt.AppendLine('You are `generateNumberSeries` API');
        SystemPrompt.AppendLine();
        SystemPrompt.AppendLine('Your task: Generate No. Series for the next entities:');
        SystemPrompt.AppendLine('"""');
        ListAllTablesWithNoSeries(SystemPrompt);
        SystemPrompt.AppendLine('"""');
        SystemPrompt.AppendLine();
        SystemPrompt.AppendLine('User might add additional instructions on how to name series.');
        SystemPrompt.AppendLine('Try to fullfil them.');
        SystemPrompt.AppendLine();
        SystemPrompt.AppendLine('IMPORTANT!');
        SystemPrompt.AppendLine('Don''t add comments.');
        SystemPrompt.AppendLine('Fill all fields.');
        SystemPrompt.AppendLine('Always respond in the next JSON format:');
        SystemPrompt.AppendLine('''''''');
        SystemPrompt.AppendLine('[');
        SystemPrompt.AppendLine('    {');
        SystemPrompt.AppendLine('        "seriesCode": "string (len 20)",');
        SystemPrompt.AppendLine('        "lineNo": "integer",');
        SystemPrompt.AppendLine('        "description": "string (len 100)",');
        SystemPrompt.AppendLine('        "startingNo": "string (len 20)",');
        SystemPrompt.AppendLine('        "endingNo": "string (len 20)",');
        SystemPrompt.AppendLine('        "warningNo": "string (len 20)",');
        SystemPrompt.AppendLine('        "incrementByNo": "integer"');
        SystemPrompt.AppendLine('    }');
        SystemPrompt.AppendLine(']');
        SystemPrompt.AppendLine('''''''');
        SystemPrompt.AppendLine();
        SystemPrompt.AppendLine('If you can''t answer or don''t know the answer, respond with: []');
        SystemPrompt.AppendLine('Your answer in a JSON format: [');
        exit(SystemPrompt.ToText());
    end;

    local procedure ListAllTablesWithNoSeries(var SystemPrompt: TextBuilder)
    var
        "Field": Record "Field";
        i: Integer;
    begin
        Field.SetFilter(FieldName, 'No. Series');
        Field.SetFilter(ObsoleteState, '<>%1', Field.ObsoleteState::Removed);
        Field.SetRange(Type, Field.Type::Code);
        Field.SetRange(Len, 20);
        if Field.FindSet() then
            repeat
                InsertObject(SystemPrompt, Field.TableNo);
                if i > 15 then
                    break;
                i += 1;
            until Field.Next() = 0;
    end;

    local procedure InsertObject(var SystemPrompt: TextBuilder; TableNo: Integer)
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        if not AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Table, TableNo) then
            exit;
        if IsObsolete(TableNo) then
            exit;
        if not IsNormal(TableNo) then
            exit;
        if IsEntryTable(TableNo) then
            exit;

        SystemPrompt.AppendLine(AllObjWithCaption."Object Caption");
    end;

    local procedure IsObsolete(TableID: Integer): Boolean
    var
        TableMetadata: Record "Table Metadata";
    begin
        if TableMetadata.Get(TableID) then
            exit(TableMetadata.ObsoleteState = TableMetadata.ObsoleteState::Removed);
    end;

    local procedure IsNormal(TableID: Integer): Boolean
    var
        TableMetadata: Record "Table Metadata";
    begin
        if TableMetadata.Get(TableID) then
            exit(TableMetadata.TableType = TableMetadata.TableType::Normal);
    end;

    local procedure IsEntryTable(TableID: Integer): Boolean
    var
        TableMetadata: Record "Table Metadata";
    begin
        if TableMetadata.Get(TableID) then
            exit(TableMetadata.Name.Contains('Entry'));
    end;

    local procedure GetEndpoint(): Text
    var
        NoSeriesCopilotSetup: Record "PKT No. Series Copilot Setup";
    begin
        exit(NoSeriesCopilotSetup.GetEndpoint())
    end;

    local procedure GetDeployment(): Text
    var
        NoSeriesCopilotSetup: Record "PKT No. Series Copilot Setup";
    begin
        exit(NoSeriesCopilotSetup.GetDeployment())
    end;

    [NonDebuggable]
    local procedure GetSecret(): Text
    var
        NoSeriesCopilotSetup: Record "PKT No. Series Copilot Setup";
    begin
        NoSeriesCopilotSetup.Get();
        exit(NoSeriesCopilotSetup.GetSecretKeyFromIsolatedStorage())
    end;

    local procedure MaxInputTokens(): Integer
    begin
        exit(MaxModelTokens() - MaxOutputTokens());
    end;

    local procedure MaxOutputTokens(): Integer
    begin
        exit(2500);
    end;

    local procedure MaxModelTokens(): Integer
    begin
        exit(4096); //PKT 3.5 Turbo
    end;

    local procedure CreateNoSeries(var GenerationId: Record "Name/Value Buffer"; var NoSeriesGenerated: Record "PKT No. Series Proposal"; Completion: Text)
    var
        JSONManagement: Codeunit "JSON Management";
        NoSeriesObj: Text;
        i: Integer;
    begin
        JSONManagement.InitializeCollection(Completion);

        for i := 0 to JSONManagement.GetCollectionCount() - 1 do begin
            JSONManagement.GetObjectFromCollectionByIndex(NoSeriesObj, i);

            InsertNoSeriesGenerated(NoSeriesGenerated, NoSeriesObj, GenerationId.ID);
        end;
    end;

    [TryFunction]
    local procedure CheckIfValidCompletion(var Completion: Text)
    var
        JsonArray: JsonArray;
    begin
        JsonArray.ReadFrom(Completion);
    end;

    local procedure SaveGenerationHistory(var GenerationId: Record "Name/Value Buffer"; InputText: Text)
    begin
        GenerationId.ID += 1;
        GenerationId."Value Long" := InputText;
        GenerationId.Insert(true);
    end;

    local procedure InsertNoSeriesGenerated(var NoSeriesGenerated: Record "PKT No. Series Proposal"; var NoSeriesObj: Text; GenerationId: Integer)
    var
        JSONManagement: Codeunit "JSON Management";
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        JSONManagement.InitializeObject(NoSeriesObj);

        RecRef.GetTable(NoSeriesGenerated);
        RecRef.Init();
        SetGenerationId(RecRef, GenerationId, NoSeriesGenerated.FieldNo("Generation Id"));
        JSONManagement.GetValueAndSetToRecFieldNo(RecRef, 'seriesCode', NoSeriesGenerated.FieldNo("Series Code"));
        JSONManagement.GetValueAndSetToRecFieldNo(RecRef, 'lineNo', NoSeriesGenerated.FieldNo("Line No."));
        JSONManagement.GetValueAndSetToRecFieldNo(RecRef, 'description', NoSeriesGenerated.FieldNo("Description"));
        JSONManagement.GetValueAndSetToRecFieldNo(RecRef, 'startingNo', NoSeriesGenerated.FieldNo("Starting No."));
        JSONManagement.GetValueAndSetToRecFieldNo(RecRef, 'endingNo', NoSeriesGenerated.FieldNo("Ending No."));
        JSONManagement.GetValueAndSetToRecFieldNo(RecRef, 'warningNo', NoSeriesGenerated.FieldNo("Warning No."));
        JSONManagement.GetValueAndSetToRecFieldNo(RecRef, 'incrementByNo', NoSeriesGenerated.FieldNo("Increment-by No."));
        RecRef.Insert(true);
    end;

    local procedure SetGenerationId(var RecRef: RecordRef; GenerationId: Integer; FieldNo: Integer)
    var
        FieldRef: FieldRef;
    begin
        FieldRef := RecRef.Field(FieldNo);
        FieldRef.Value(GenerationId);
    end;

    procedure ApplyProposedNoSeries(var NoSeriesGenerated: Record "PKT No. Series Proposal")
    begin
        if NoSeriesGenerated.FindSet() then
            repeat
                InsertNoSeriesWithLines(NoSeriesGenerated);
            until NoSeriesGenerated.Next() = 0;
    end;

    local procedure InsertNoSeriesWithLines(var NoSeriesGenerated: Record "PKT No. Series Proposal")
    begin
        InsertNoSeries(NoSeriesGenerated);
        InsertNoSeriesLine(NoSeriesGenerated);
    end;

    local procedure InsertNoSeries(var NoSeriesGenerated: Record "PKT No. Series Proposal")
    var
        NoSeries: Record "No. Series";
    begin
        NoSeries.Init();
        NoSeries.Code := NoSeriesGenerated."Series Code";
        NoSeries.Description := NoSeriesGenerated.Description;
        NoSeries."Manual Nos." := true;
        NoSeries."Default Nos." := true;
        NoSeries.Insert(true);
    end;

    local procedure InsertNoSeriesLine(var NoSeriesGenerated: Record "PKT No. Series Proposal")
    var
        NoSeriesLine: Record "No. Series Line";
    begin
        NoSeriesLine.Init();
        NoSeriesLine."Series Code" := NoSeriesGenerated."Series Code";
        NoSeriesLine."Line No." := NoSeriesGenerated."Line No.";
        NoSeriesLine."Starting No." := NoSeriesGenerated."Starting No.";
        NoSeriesLine."Ending No." := NoSeriesGenerated."Ending No.";
        NoSeriesLine."Warning No." := NoSeriesGenerated."Warning No.";
        NoSeriesLine."Increment-by No." := NoSeriesGenerated."Increment-by No.";
        NoSeriesLine.Insert(true);
    end;
}