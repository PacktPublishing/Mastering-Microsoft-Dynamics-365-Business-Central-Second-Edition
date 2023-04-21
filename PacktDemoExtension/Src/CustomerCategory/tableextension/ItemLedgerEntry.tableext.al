tableextension 50101 "PKT ItemLedgerEntryExt" extends "Item Ledger Entry"
{
    fields
    {
        //Field added during Sales Post
        field(50100; "PKT Customer Category Code"; Code[20])
        {
            Caption = 'Customer Category';
            TableRelation = "PKT Customer Category";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PKTK1; "PKT Customer Category Code")
        {
        }
    }
}