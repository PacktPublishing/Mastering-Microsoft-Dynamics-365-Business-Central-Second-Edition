pageextension 60000 "PACKT DocumentAttachmentDetExt" extends "Document Attachment Details"
{
    actions
    {
        addlast(processing)
        {
            action("PACKT View PDF")
            {
                ApplicationArea = All;
                Image = Text;
                Caption = 'View PDF';
                ToolTip = 'View PDF';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = Rec."File Extension" = 'pdf';
                trigger OnAction()
                var
                    PDFViewerDocAttachment: Page "PACKT PDF Viewer Doc. Attachmt";
                begin
                    PDFViewerDocAttachment.SetRecord(Rec);
                    PDFViewerDocAttachment.SetTableView(Rec);
                    PDFViewerDocAttachment.Run();
                end;
            }
        }
    }
}
