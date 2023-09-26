codeunit 50702 "PKT Trigger Helper"
{
    SingleInstance = true;

    var
        TriggerList: List of [text];

    procedure Init()
    begin
        clear(TriggerList);
    end;

    procedure Add(name: Text)
    begin
        TriggerList.Add(name);
    end;

    procedure Save(path: Text)
    var
        LogTable: Record "PKT Report Triggers Log Table";
        item: Text[150];
        OutStr: OutStream;
        textBuilder: TextBuilder;
    begin
        LogTable.Init();
        LogTable."Entry No." := LogTable.GetLastEntryNo() + 1;
        LogTable."Type" := 'EventSequenceFile';
        LogTable."Output File Name" := path;
        LogTable."Is Text Encoded" := true;
        LogTable."Output File".CreateOutStream(OutStr, TextEncoding::UTF8);

        foreach item in TriggerList
        do begin
            textBuilder.AppendLine(item);
        end;

        OutStr.WriteText(textBuilder.ToText());
        LogTable.Insert(true);
        Commit();
    end;

    procedure Reset()
    begin
        clear(TriggerList);
    end;
}

