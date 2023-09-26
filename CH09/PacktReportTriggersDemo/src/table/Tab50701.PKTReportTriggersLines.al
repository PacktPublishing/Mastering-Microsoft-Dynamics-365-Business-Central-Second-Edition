table 50701 "PKT Report Triggers Lines"
{

    fields
    {
        field(1; KeyField; Integer)
        {
        }
        field(2; ItemLine1; Text[30])
        {
        }
        field(3; ItemLine2; Text[30])
        {
        }
        field(4; ParentReportItem; Integer)
        {
        }
        field(5; ItemDecimal; Decimal)
        {
        }
        field(6; ItemPicture; BLOB)
        {
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; KeyField)
        {
            Clustered = true;
        }
    }

}

