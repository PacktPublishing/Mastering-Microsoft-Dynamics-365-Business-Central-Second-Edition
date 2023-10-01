reportextension 50111 SalesOrderConfExt extends "Standard Sales - Order Conf."
{
    dataset
    {
        modify(Header)
        {       
            trigger OnAfterAfterGetRecord()
            begin
                Customer.get(Header."Bill-to Customer No.");
            end;
        }
        
        add(Header)
        {
            column(CustomerCategory_PKT;Customer."PKT Customer Category Code") { }           
            column(CustomerCategory_PKT_Lbl;Customer.FIELDCAPTION("PKT Customer Category Code")) { }
            column(Giftlbl;Giftlbl) { }
        }

        modify(Line)
        {       
            trigger OnAfterAfterGetRecord()
            begin
                case "Line Discount %" of
                    0    : NewLineDiscountPctText := '';
                    100  : NewLineDiscountPctText := GiftLbl;
                else
                    NewLineDiscountPctText := StrSubstNo('%1%',-Round("Line Discount %",0.1));
                end;
            end;
        }

        add(Line)
        {
            column(newLineDiscountPctText;newLineDiscountPctText) { }
        }
    }
        
    rendering
    {
        layout(LayoutWord)
        {
            Type = Word;
            Caption = 'PKT Standard Sales - Order Conf.';
            Summary = 'Standard Sales - Order Conf. report ext.';
            LayoutFile = '.\Src\Gifts\reportextension\SalesOrderConfExt.reportext.docx';
        }
    }

    var
        Customer : Record Customer;
        newLineDiscountPctText : Text;
        Giftlbl : Label 'GIFT';
}