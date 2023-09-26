codeunit 50703 "PKT Install"
{
    Subtype = Install;
    
    trigger OnInstallAppPerCompany()
    begin
        InitData(3, 2);
    end;

    procedure InitData(DataItemCount: Integer; LineCount: Integer)
    var
        DataItem: Record "PKT Report Triggers";
        LineItem: Record "PKT Report Triggers Lines";
        i: Integer;
        j: Integer;
        k: Integer;
        counter: Integer;
    begin
        // Initialize test data for the report.
        DataItem.DeleteAll;
        LineItem.DeleteAll;
        counter := 1;
        for i := 1 to DataItemCount do begin
            DataItem.Init;
            DataItem.TextField := StrSubstNo('Text%1', i);
            DataItem.CodeField := StrSubstNo('Code%1', i);
            DataItem.IntegerField := i;
            DataItem.BigIntField := i * 1000;
            DataItem.DecimalFieldNoFormat := i * 1.5555;
            DataItem.DecimailFieldWithFormat := i * 2.7777;
            DataItem.KeyField := i;
            DataItem.Date := 20141015D + i;
            DataItem.Time := 150000T + i * 1000;
            DataItem.DateTime := CreateDateTime(DataItem.Date, DataItem.Time);
            DataItem.Duration := i * 1000;
            DataItem.Text_Url := GetUrl(CLIENTTYPE::Web, CompanyName, OBJECTTYPE::Page, PAGE::"PKT Report Triggers List", DataItem, false);
            DataItem.Text_UrlText := 'Description: ' + GetUrl(CLIENTTYPE::Web, CompanyName, OBJECTTYPE::Page, PAGE::"PKT Report Triggers List");
            DataItem.Insert;

            for j := 1 to LineCount do begin
                LineItem.Init;
                LineItem.KeyField := i * 100 + j;
                LineItem.ItemDecimal := i * 1000 + j;
                LineItem.ItemLine1 := StrSubstNo('LineItemA%1', i * 100 + j);
                LineItem.ItemLine2 := StrSubstNo('LineItemB%1', i * 100 + j);
                LineItem.ParentReportItem := i;
                LineItem.Insert;
            end;
        end;
    end;

}