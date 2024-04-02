#pragma warning disable AA0215
table 50000 GenericTable
#pragma warning restore AA0215
{
    /*
        #000 SQD NMC 27032024 [NAV UNIT TESTING / XML DOC / GENERATE LANDING PAGE]
    */

    Caption = 'Generic Table Data';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "ID"; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = AccountData;
        }
        field(50001; "Entry Type"; Enum GenericTableEnum)
        {
            Caption = 'Entry Type';
            DataClassification = SystemMetadata;
        }
        field(50002; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(50003; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; ID, "Entry Type", "No.")
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// Checks if a given ID number exists in the table.
    /// </summary>
    /// <param name="pID">Given ID.</param>
    /// <returns>True if a given ID exists or False if it doesn't.</returns>
    procedure CheckIDExists(pID: Integer): Boolean
    var
        recTestTable: Record GenericTable;
    begin
        Clear(recTestTable);
        if (recTestTable.Get(ID, pID)) then
            exit(true);

        exit(false);
    end;

    /// <summary>
    /// Inserts new entry into record.
    /// </summary>
    procedure InsertNew()
    var
        recTestTable: Record GenericTable;
    begin
        Clear(recTestTable);
        if (recTestTable.FindLast()) then
            Rec.ID := recTestTable.ID + 1
        else
            Rec.ID := 1;
    end;

    /// <summary>
    /// Insert a new Typed Entry to generic table.
    /// </summary>
    /// <param name="pEntryType">Entry Type</param>
    /// <param name="pDescription">Description</param>
    procedure InsertNewTypedRecord(pEntryType: Enum GenericTableEnum; pDescription: Text)
    var
        recTestTable: Record GenericTable;
        varAuxString: Text;
#pragma warning disable AA0470
        varDefaultItemDescriptionTxt: Label 'Item %1 ALIAS';
        varCustomerDescriptionTxt: Label 'Customer %1 ALIAS';
        varVendorDescriptionTxt: Label 'Vendor %1 ALIAS';
#pragma warning restore AA0470
    begin
        Clear(recTestTable);
        if (recTestTable.IsEmpty) then
            Rec.ID := 1
        else
            if recTestTable.FindLast() then
                Rec.ID := recTestTable.ID + 1;

        Rec."Entry Type" := pEntryType;
        case pEntryType of
            pEntryType::Customer:
                begin
                    Clear(recTestTable);
                    recTestTable.SetRange("Entry Type", recTestTable."Entry Type"::Customer);
                    if recTestTable.FindLast() then begin
                        // Last Entry Type Customer 
                        Clear(varAuxString);
                        varAuxString := IncStr(recTestTable."No.");
                        Rec."No." := Format(varAuxString);
                    end else
                        // No Entry Type Customer
                        Rec."No." := 'CT0001';

                    if (pDescription <> '') then
                        Rec.Description := CopyStr(pDescription, 1, MaxStrLen(Rec.Description))
                    else
                        Rec.Description := StrSubstNo(varCustomerDescriptionTxt, Rec."No.");
                end;
            pEntryType::Vendor:
                begin
                    Clear(recTestTable);
                    recTestTable.SetRange("Entry Type", recTestTable."Entry Type"::Vendor);
                    if recTestTable.FindLast() then begin
                        // Last Entry Type Vendor
                        Clear(varAuxString);
                        varAuxString := IncStr(recTestTable."No.");
                        Rec."No." := Format(varAuxString);
                    end else
                        // No Entry Type Vendor
                        Rec."No." := 'VD0001';

                    if (pDescription <> '') then
                        Rec.Description := CopyStr(pDescription, 1, MaxStrLen(Rec.Description))
                    else
                        Rec.Description := StrSubstNo(varVendorDescriptionTxt, Rec."No.");
                end;
            pEntryType::Item:
                begin
                    Clear(recTestTable);
                    recTestTable.SetRange("Entry Type", recTestTable."Entry Type"::Item);
                    if recTestTable.FindLast() then begin
                        // Last Entry Type Item
                        Clear(varAuxString);
                        varAuxString := IncStr(recTestTable."No.");
                        Rec."No." := Format(varAuxString);
                    end else
                        // No Entry Type Item
                        Rec."No." := 'IT0001';

                    if (pDescription <> '') then
                        Rec.Description := CopyStr(pDescription, 1, MaxStrLen(Rec.Description))
                    else
                        Rec.Description := StrSubstNo(varDefaultItemDescriptionTxt, Rec."No.");
                end;
        end;
    end;
}