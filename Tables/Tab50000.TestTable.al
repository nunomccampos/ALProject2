table 50000 TestTable
{
    /*
        Documentação    
    */

    //TODO - Test Table  
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "ID"; Integer)
        {
            Caption = 'MyField';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

}