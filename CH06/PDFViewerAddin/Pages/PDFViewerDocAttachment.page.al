page 60000 "PACKT PDF Viewer Doc. Attachmt"
{
    Caption = 'PDF Viewer';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Document Attachment";
    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                usercontrol(PDFViewer; "PACKT PDF Viewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddinReady()
                    begin
                        SetPDFDocument();
                    end;
                }
            }
        }
    }
    local procedure SetPDFDocument()
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStreamVar: InStream;
        OutStreamVar: OutStream;
        PDFAsTxt: Text;
    begin
        CurrPage.PDFViewer.SetVisible(Rec."Document Reference ID".HasValue());
        if not Rec."Document Reference ID".HasValue() then
            exit;

        TempBlob.CreateInStream(InStreamVar);
        TempBlob.CreateOutStream(OutStreamVar);
        Rec."Document Reference ID".ExportStream(OutStreamVar);

        PDFAsTxt := Base64Convert.ToBase64(InStreamVar);

        CurrPage.PDFViewer.LoadPDF(PDFAsTxt, false);
    end;
}
