page 80003 "PDFV PDF Viewer Matrix"
{

    Caption = 'PDF Documents';
    PageType = CardPart;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(Group1)
            {
                ShowCaption = false;
                Visible = VisibleControl1;
                usercontrol(PDFViewer1; "PDFV PDF Viewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddinReady()
                    begin
                        IsControlAddInReady := true;
                        SetRecord();
                    end;

                    trigger onView()
                    begin
                        RunFullView(PDFStorageArray[1]);
                    end;
                }
            }
            group(Group2)
            {
                ShowCaption = false;
                Visible = VisibleControl2;
                usercontrol(PDFViewer2; "PDFV PDF Viewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddinReady()
                    begin
                        IsControlAddInReady := true;
                        SetRecord();
                    end;

                    trigger onView()
                    begin
                        RunFullView(PDFStorageArray[2]);
                    end;
                }
            }
            group(Group3)
            {
                ShowCaption = false;
                Visible = VisibleControl3;
                usercontrol(PDFViewer3; "PDFV PDF Viewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddinReady()
                    begin
                        IsControlAddInReady := true;
                        SetRecord();
                    end;

                    trigger onView()
                    begin
                        RunFullView(PDFStorageArray[3]);
                    end;
                }
            }
            group(Group4)
            {
                ShowCaption = false;
                Visible = VisibleControl4;
                usercontrol(PDFViewer4; "PDFV PDF Viewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddinReady()
                    begin
                        IsControlAddInReady := true;
                        SetRecord();
                    end;

                    trigger onView()
                    begin
                        RunFullView(PDFStorageArray[4]);
                    end;
                }
            }
            group(Group5)
            {
                ShowCaption = false;
                Visible = VisibleControl5;
                usercontrol(PDFViewer5; "PDFV PDF Viewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddinReady()
                    begin
                        IsControlAddInReady := true;
                        SetRecord();
                    end;

                    trigger onView()
                    begin
                        RunFullView(PDFStorageArray[5]);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin

    end;

    local procedure GetPDFAsTxt(PDFStorage: Record "PDFV PDF Storage"): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStreamVar: InStream;
    begin
        PDFStorage.CalcFields("PDF Value");
        if not PDFStorage."PDF Value".HasValue() then
            exit;

        TempBlob.FromRecord(PDFStorage, PDFStorage.FieldNo("PDF Value"));
        TempBlob.CreateInStream(InStreamVar);

        exit(Base64Convert.ToBase64(InStreamVar));
    end;

    local procedure SetPDFDocument(PDFAsTxt: Text; i: Integer);
    var
        IsVisible: Boolean;
    begin
        IsVisible := PDFAsTxt <> '';
        case i of
            1:
                begin
                    VisibleControl1 := IsVisible;
                    if not IsVisible or not IsControlAddInReady then
                        exit;
                    CurrPage.PDFViewer1.SetVisible(IsVisible);
                    CurrPage.PDFViewer1.LoadPDF(PDFAsTxt, true);
                end;
            2:
                begin

                    VisibleControl2 := IsVisible;
                    if not IsVisible or not IsControlAddInReady then
                        exit;
                    CurrPage.PDFViewer2.SetVisible(IsVisible);
                    CurrPage.PDFViewer2.LoadPDF(PDFAsTxt, true);
                end;
            3:
                begin
                    VisibleControl3 := IsVisible;
                    if not IsVisible or not IsControlAddInReady then
                        exit;
                    CurrPage.PDFViewer3.SetVisible(IsVisible);
                    CurrPage.PDFViewer3.LoadPDF(PDFAsTxt, true);
                end;
            4:
                begin
                    VisibleControl4 := IsVisible;
                    if not IsVisible or not IsControlAddInReady then
                        exit;
                    CurrPage.PDFViewer4.SetVisible(IsVisible);
                    CurrPage.PDFViewer4.LoadPDF(PDFAsTxt, true);
                end;
            5:
                begin
                    VisibleControl5 := IsVisible;
                    if not IsVisible or not IsControlAddInReady then
                        exit;
                    CurrPage.PDFViewer5.SetVisible(IsVisible);
                    CurrPage.PDFViewer5.LoadPDF(PDFAsTxt, true);
                end;
        end;

    end;

    local procedure SetRecord()
    var
        PDFStorage: Record "PDFV PDF Storage";
        HandleErr: Boolean;
        i: Integer;
    begin
        Clear(PDFStorageArray);
        Clear(VisibleControl1);
        Clear(VisibleControl2);
        Clear(VisibleControl3);
        Clear(VisibleControl4);
        Clear(VisibleControl5);
        PDFStorage.SetRange("Source Record ID", gSourceRecordId);
        if PDFStorage.FindSet() then
            repeat
                i += 1;
                Clear(PDFStorageArray[i]);
                HandleErr := PDFStorageArray[i].Get(PDFStorage."Entry No.");
            until (PDFStorage.Next() = 0) or (i = ArrayLen(PDFStorageArray));

        SetPDFDocument(GetPDFAsTxt(PDFStorageArray[1]), 1);
        SetPDFDocument(GetPDFAsTxt(PDFStorageArray[2]), 2);
        SetPDFDocument(GetPDFAsTxt(PDFStorageArray[3]), 3);
        SetPDFDocument(GetPDFAsTxt(PDFStorageArray[4]), 4);
        SetPDFDocument(GetPDFAsTxt(PDFStorageArray[5]), 5);
    end;

    procedure SetRecord(SourceRecordID: RecordId)
    begin
        gSourceRecordId := SourceRecordID;
        SetRecord();
        CurrPage.Update(false);
    end;

    local procedure RunFullView(PDFStorage: Record "PDFV PDF Storage")
    var
        PDFViewerCard: Page "PDFV PDF Viewer";
    begin
        if PDFStorage.IsEmpty() then
            exit;
        PDFViewerCard.SetRecord(PDFStorage);
        PDFViewerCard.SetTableView(PDFStorage);
        PDFViewerCard.Run();
    end;

    var
        PDFStorageArray: array[5] of Record "PDFV PDF Storage";
        gSourceRecordId: RecordId;
        [InDataSet]
        VisibleControl1: Boolean;
        [InDataSet]
        VisibleControl2: Boolean;
        [InDataSet]
        VisibleControl3: Boolean;
        [InDataSet]
        VisibleControl4: Boolean;
        [InDataSet]
        VisibleControl5: Boolean;
        [InDataSet]
        IsControlAddInReady: Boolean;
}
