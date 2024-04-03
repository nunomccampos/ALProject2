#pragma warning disable AA0215
codeunit 50000 UTCodeunit
#pragma warning restore AA0215
{
    /*
        #000 SQD NMC 27032024 [NAV UNIT TESTING / XML DOC / GENERATE LANDING PAGE]
    */

    Subtype = Test;

    // Makes the method a test method
    [Test]

    // Adds the test logic to the test method
    procedure TestDefaultInsertMethod()
    var
        recTestTable: Record GenericTable;
#pragma warning disable AA0470
        varDefaultItemDescriptionTxt: Label 'Item %1 ALIAS';
        varCustomerDescriptionTxt: Label 'Customer %1 ALIAS';
        varVendorDescriptionTxt: Label 'Vendor %1 ALIAS';
#pragma warning restore AA0470
        i: Integer;
        varDescriptionAux: Label 'IT000%1';
    begin
        // [SCENARIO] 
        // Insert an empty record and check if description matches the default behavior.

        // [GIVEN] 
        // Generic Table Record

        // [WHEN] Insert a new record with An Empty description.
        for i := 1 to 9 do begin
            // Empty Default
            //InsertNewTypedRecord(recTestTable, recTestTable."Entry Type"::Item, 'testa esta merda direito');
            // With Description
            InsertNewTypedRecord(recTestTable, recTestTable."Entry Type"::Item, StrSubstNo(varDefaultItemDescriptionTxt, StrSubstNo(varDescriptionAux, i)));

            // [THEN] should insert by default with ALIAS description.
            CheckDefaultDescriptionFromTypedRecord(recTestTable."Entry Type"::Item);
        end;
    end;

    procedure InsertNewTypedRecord(var pGenericTable: Record GenericTable; pEntryType: Enum GenericTableEnum; pDescription: Text)
    var
        recTestTable: Record GenericTable;
        varAuxString: Text;
#pragma warning disable AA0470
        varDefaultItemDescriptionTxt: Label 'Item %1 ALIAS';
        varCustomerDescriptionTxt: Label 'Customer %1 ALIAS';
        varVendorDescriptionTxt: Label 'Vendor %1 ALIAS';
#pragma warning restore AA0470
    begin
        if pGenericTable.FindLast() then
            pGenericTable.ID += 1
        else
            pGenericTable.ID := 1;

        pGenericTable."Entry Type" := pEntryType;
        case pEntryType of
            pEntryType::Customer:
                begin
                    Clear(recTestTable);
                    recTestTable.SetRange("Entry Type", recTestTable."Entry Type"::Customer);
                    if recTestTable.FindLast() then begin
                        // Last Entry Type Customer 
                        Clear(varAuxString);
                        varAuxString := IncStr(recTestTable."No.");
                        pGenericTable."No." := Format(varAuxString);
                    end else
                        // No Entry Type Customer
                        pGenericTable."No." := 'CT0001';

                    pGenericTable."Entry Type" := pEntryType;

                    if (pDescription <> '') then
                        pGenericTable.Description := CopyStr(pDescription, 1, MaxStrLen(pGenericTable.Description))
                    else
                        pGenericTable.Description := StrSubstNo(varCustomerDescriptionTxt, pGenericTable."No.");
                end;
            pEntryType::Vendor:
                begin
                    Clear(recTestTable);
                    recTestTable.SetRange("Entry Type", recTestTable."Entry Type"::Vendor);
                    if recTestTable.FindLast() then begin
                        // Last Entry Type Vendor
                        Clear(varAuxString);
                        varAuxString := IncStr(recTestTable."No.");
                        pGenericTable."No." := Format(varAuxString);
                    end else
                        // No Entry Type Vendor
                        pGenericTable."No." := 'VD0001';

                    pGenericTable."Entry Type" := pEntryType;

                    if (pDescription <> '') then
                        pGenericTable.Description := CopyStr(pDescription, 1, MaxStrLen(recTestTable.Description))
                    else
                        pGenericTable.Description := StrSubstNo(varVendorDescriptionTxt, pGenericTable."No.");
                end;
            pEntryType::Item:
                begin
                    Clear(recTestTable);
                    recTestTable.SetRange("Entry Type", recTestTable."Entry Type"::Item);
                    if recTestTable.FindLast() then begin
                        // Last Entry Type Item
                        Clear(varAuxString);
                        varAuxString := IncStr(recTestTable."No.");
                        pGenericTable."No." := Format(varAuxString);
                    end else
                        // No Entry Type Item
                        pGenericTable."No." := 'IT0001';

                    pGenericTable."Entry Type" := pEntryType;

                    if (pDescription <> '') then
                        pGenericTable.Description := CopyStr(pDescription, 1, MaxStrLen(recTestTable.Description))
                    else
                        pGenericTable.Description := StrSubstNo(varDefaultItemDescriptionTxt, pGenericTable."No.");
                end;
        end;
        pGenericTable.Insert();
    end;

    // Creates the test helper method
    local procedure GetEnumValueName(pEnumName: Enum GenericTableEnum): Text
    var
        varIndex: Integer;
        varValueName: Text;
    begin
        Clear(varValueName);
        varIndex := pEnumName.Ordinals().IndexOf(pEnumName.AsInteger());
        pEnumName.Names().Get(varIndex, varValueName);
        exit(varValueName);
    end;

    local procedure CheckDefaultDescriptionFromTypedRecord(pEntryType: Enum GenericTableEnum)
    var
        varEntryTypeName: Text;
        recGenericTable: Record GenericTable;
    begin
        Clear(recGenericTable);
        recGenericTable.SetRange("Entry Type", pEntryType);
        if (recGenericTable.FindLast()) then begin
            Clear(varEntryTypeName);
            varEntryTypeName := GetEnumValueName(pEntryType);
            recGenericTable.TestField(Description, StrSubstNo('%1 %2 %3', varEntryTypeName, recGenericTable."No.", 'ALIAS'));
        end;
    end;

    var
    //FIXME 
    // Assert: Codeunit Assert; (??)
    // Assert: Codeunit "Library Assert" (Cloud)
    // System.TestLibraries.Utilities.Library-Assert
}