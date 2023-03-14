codeunit 50100 "SD Attached Documents Mgt."
{
    //Upload the Blob to Blob Storage
    [EventSubscriber(ObjectType::table, Database::"Document Attachment", 'OnBeforeInsertAttachment', '', true, true)]
    local procedure OnBeforeImportWithFilter(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ABSBlobClient: codeunit "ABS Blob Client";
        Authorization: Interface "Storage Service Authorization";
        ABSContainerSetup: Record "SD ABS Container Setup";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        InS: InStream;
        OutS: OutStream;
        tempBlob: Codeunit "Temp Blob";
        Filename: Text;
    begin
        ABSContainerSetup.Get;
        Authorization := StorageServiceAuthorization.CreateSharedKey(ABSContainerSetup."Shared Access Key");
        ABSBlobClient.Initialize(ABSContainerSetup."Account Name", ABSContainerSetup."Container Name", Authorization);
        //Copy from outstream to instream
        tempBlob.CreateOutStream(OutS);
        DocumentAttachment."Document Reference ID".ExportStream(OutS);
        tempBlob.CreateInStream(InS);
        Filename := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
        ABSBlobClient.PutBlobBlockBlobStream(Filename, InS);
    end;

    //When you delete the file, also the file from the Blob Storage must be deleted
    [EventSubscriber(ObjectType::table, Database::"Document Attachment", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure DeleteDocumentAttachment(var Rec: Record "Document Attachment"; RunTrigger: Boolean)
    var
        ABSBlobClient: codeunit "ABS Blob Client";
        Authorization: Interface "Storage Service Authorization";
        ABSContainerSetup: Record "SD ABS Container Setup";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Filename: Text;
    begin
        If RunTrigger then begin
            ABSContainerSetup.Get;
            Authorization := StorageServiceAuthorization.CreateSharedKey(ABSContainerSetup."Shared Access Key");
            ABSBlobClient.Initialize(ABSContainerSetup."Account Name", ABSContainerSetup."Container Name", Authorization);
            Filename := Rec."File Name" + '.' + Rec."File Extension";
            ABSBlobClient.DeleteBlob(Filename);
        end;
    end;

    //Delete the file from the Media field
    [EventSubscriber(ObjectType::table, Database::"Document Attachment", 'OnAfterInsertEvent', '', true, true)]
    local procedure DeleteMediaField(var Rec: Record "Document Attachment"; RunTrigger: Boolean)
    begin
        If RunTrigger then begin
            Clear(Rec."Document Reference ID");
            Rec.Modify();
        end;
    end;
}