page 80001 "PDFV PDF Viewer Factbox"
{

    Caption = 'PDF Viewer';
    PageType = CardPart;
    SourceTable = "PDFV PDF Storage";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                usercontrol(PDFViewer; "PDFV PDF Viewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddinReady()
                    begin
                        SetPDFDocument();
                    end;

                    trigger onView()
                    begin
                        RunFullView();
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PDFVViewFullDocument)
            {
                ApplicationArea = All;
                Image = View;
                Caption = 'View';
                ToolTip = 'View';
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Promoted = true;
                trigger OnAction()
                begin
                    RunFullView();
                end;
            }
        }
    }
    local procedure SetPDFDocument()
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStreamVar: InStream;
        PDFAsTxt: Text;
    begin
        Rec.CalcFields("PDF Value");
        CurrPage.PDFViewer.SetVisible(Rec."PDF Value".HasValue());
        if not Rec."PDF Value".HasValue() then
            exit;

        TempBlob.FromRecord(Rec, Rec.FieldNo("PDF Value"));
        TempBlob.CreateInStream(InStreamVar);

        PDFAsTxt := Base64Convert.ToBase64(InStreamVar);

        CurrPage.PDFViewer.LoadPDF(PDFAsTxt, true);
    end;

    procedure SetRecord(EntryNo: BigInteger)
    begin
        Rec.SetRange("Entry No.", EntryNo);
        if not Rec.FindFirst() then
            exit;
        SetPDFDocument();
        CurrPage.Update(false);
    end;

    local procedure RunFullView()
    var
        PDFViewerCard: Page "PDFV PDF Viewer";
    begin
        if Rec.IsEmpty() then
            exit;
        PDFViewerCard.SetRecord(Rec);
        PDFViewerCard.SetTableView(Rec);
        PDFViewerCard.Run();
    end;
}
