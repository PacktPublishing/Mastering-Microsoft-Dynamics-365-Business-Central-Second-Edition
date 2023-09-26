table 50703 "PKT Report Triggers Log Table"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Output File Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Output File"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Is Text Encoded"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure GetLastEntryNo() : Integer
    var
        LogTable : Record "PKT Report Triggers Log Table";
    begin
        LogTable.Reset();
        if LogTable.IsEmpty then 
            exit(0)
        else begin
            LogTable.FindLast();
            exit(LogTable."Entry No.");    
        end;
    end;

}

