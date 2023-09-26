table 50700 "PKT Report Triggers"
{

    fields
    {
        field(1; TextField; Text[128])
        {
        }
        field(2; CodeField; Code[10])
        {
        }
        field(3; IntegerField; Integer)
        {
        }
        field(4; BigIntField; BigInteger)
        {
        }
        field(5; DecimalFieldNoFormat; Decimal)
        {
        }
        field(6; DecimailFieldWithFormat; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(7; KeyField; Integer)
        {
        }
        field(8; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(9; Date; Date)
        {
        }
        field(10; DateTime; DateTime)
        {
        }
        field(11; Time; Time)
        {
        }
        field(12; Duration; Duration)
        {
        }
        field(13; Picture_Url; Text[250])
        {
        }
        field(14; Text_Url; Text[250])
        {
        }
        field(15; Text_UrlText; Text[250])
        {
        }
        field(16; PictureMedia; Media)
        {
        }
        field(17; PictureMediaSet; MediaSet)
        {
        }
    }

    keys
    {
        key(Key1; TextField)
        {
            Clustered = true;
        }
    }
}

