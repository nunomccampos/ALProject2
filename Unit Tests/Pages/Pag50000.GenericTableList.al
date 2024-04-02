#pragma warning disable AA0215
page 50000 GenericTableList
#pragma warning restore AA0215
{
    /*
        #000 SQD NMC 27032024 [NAV UNIT TESTING / XML DOC / GENERATE LANDING PAGE]
    */

    PageType = List;
    ApplicationArea = Basic;
    UsageCategory = Administration;
    SourceTable = GenericTable;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'Record List';
                repeater(GenericRecordList)
                {
                    field(RecordID; Rec.ID)
                    {
                        Caption = 'Entry No.';
                        ToolTip = 'Entry Number of record.';
                    }
                    field("Entry Type"; Rec."Entry Type")
                    {
                        Caption = 'Entry Type';
                        ToolTip = 'Entry Type of record.';
                    }
                    field("No."; Rec."No.")
                    {
                        Caption = 'No.';
                        ToolTip = 'No. of record.';
                    }
                    field(Description; Rec.Description)
                    {
                        Caption = 'Description';
                        ToolTip = 'Brief description of record.';
                    }
                }
            }
        }
    }
}