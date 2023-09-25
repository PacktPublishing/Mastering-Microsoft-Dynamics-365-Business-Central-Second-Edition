pageextension 50100 SDCustomerCardExt extends "Customer Card"
{
    actions
    {
        addlast(processing)
        {
            action(SDQRCode)
            {
                ApplicationArea = All;
                Caption = 'Generate Customer QR Code';
                Image = BarCode;

                trigger OnAction()
                var
                    AFDemo: Codeunit "SD Azure Functions Demo";
                begin
                    AFDemo.GenerateQRCode(Rec."No.", Rec."Home Page");
                end;
            }
        }
        addlast(Promoted)
        {
            actionref(SDQRCodeRef; SDQRCode)
            {
            }
        }
    }
}