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
    begin
        // [SCENARIO] 
        // Insert an empty record and check if description matches the default behavior.

        // [GIVEN] 
        // Generic Table Record

        // [WHEN] Insert a new record with An Empty description.
        recTestTable.InsertNewTypedRecord(recTestTable."Entry Type"::Item, '');

        // [THEN] should insert by default with ALIAS description.
        CheckDefaultDescriptionFromTypedRecord(recTestTable."Entry Type"::Item);
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
        recTestTable: Record GenericTable;
        varEntryTypeName: Text;
    begin
        Clear(recTestTable);
        recTestTable.SetRange("Entry Type", pEntryType);
        if (recTestTable.FindLast()) then begin
            Clear(varEntryTypeName);
            varEntryTypeName := GetEnumValueName(pEntryType);
            recTestTable.TestField(Description, StrSubstNo('%1 %2 %3', varEntryTypeName, recTestTable."No.", 'ALIAS'));
            // Adapt to use the Assert Codeunit
            //FIXME Assert.AreEqual(recTestTable.Description, StrSubstNo('%1 %2 %3', varEntryTypeName, recTestTable."No.", 'ALIAS'));
        end;
    end;

    var
    //FIXME 
    // Assert: Codeunit Assert; (??)
    // Assert: Codeunit "Library Assert" (Cloud)
    // System.TestLibraries.Utilities.Library-Assert
}