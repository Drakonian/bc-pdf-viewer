page 80000 "PDFV PDF Viewer"
{

    Caption = 'PDF Viewer';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "PDFV PDF Storage";
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
                }
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

        CurrPage.PDFViewer.LoadPDF(PDFAsTxt, false);
    end;
}
