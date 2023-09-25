report 50111 "Item Ledger Entry Analysis"
{
    DefaultRenderingLayout = LayoutRDL;
    EnableExternalImages = true;

    Caption = 'Item Ledger Entry Analysis';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
                IncludeCaption = true;
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
                IncludeCaption = true;
            }
            column(EntryType_ItemLedgerEntry; "Item Ledger Entry"."Entry Type")
            {
                IncludeCaption = true;
            }
            column(CustCatPKT_ItemLedgerEntry; "Item Ledger Entry"."PKT Customer Category Code")
            {
                IncludeCaption = true;
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
                IncludeCaption = true;
            }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
                IncludeCaption = true;
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
                IncludeCaption = true;
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
                IncludeCaption = true;
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(includeLogo; includeLogo)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
        }
    }
    
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(includeLogo; includeLogo)
                    {
                        Caption = 'Include company logo';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    rendering
    {
        layout(LayoutRDL)
        {
            Type = RDLC;
            Caption = 'LayoutRDL';
            Summary = 'Item Ledger Entry Analysis RDL Report';
            LayoutFile = '.\Src\CustomerCategory\report\Rep50111.ItemLedgerEntryAnalysis.rdl';
        }
        layout(LayoutWord)
        {
            Type = Word;

            Caption = 'LayoutWord';
            Summary = 'Item Ledger Entry Analysis Word Report';
            LayoutFile = '.\Src\CustomerCategory\report\Rep50111.ItemLedgerEntryAnalysis.docx';
        }

        layout(LayoutExcel)
        {
            Type = Excel;
            Caption = 'LayoutExcel';
            Summary = 'Item Ledger Entry Analysis Excel Report';
            LayoutFile = '.\Src\CustomerCategory\report\Rep50111.ItemLedgerEntryAnalysis.xlsx';
        }
    }

    labels
    {
        PageNo = 'Page'; 
        BCReportName = 'Item Ledger Entry Analysis'; 
    }

    trigger OnPreReport()
    begin
        if includeLogo then begin
            CompanyInfo.Get();  //Get Company Information record
            CompanyInfo.CalcFields(Picture);  //Retrieve company logo
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        includeLogo: Boolean;

}
