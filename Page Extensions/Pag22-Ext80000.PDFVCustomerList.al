pageextension 80000 "PDFV Customer List" extends "Customer List" //22
{
    layout
    {
        addfirst(factboxes)
        {
            part(PDFViewerMatrix; "PDFV PDF Viewer Matrix")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            action(PDFVPDFStorage)
            {
                ApplicationArea = All;
                Image = Database;
                Caption = 'PDF Storage';
                ToolTip = 'PDF Storage';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PDFStorage: Record "PDFV PDF Storage";
                    PDFStorageList: Page "PDFV PDF Storage";
                begin
                    Clear(PDFStorageList);
                    PDFStorage.SetRange("Source Record ID", Rec.RecordId());
                    PDFStorageList.SetTableView(PDFStorage);
                    PDFStorageList.Run();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.PDFViewerMatrix.Page.SetRecord(Rec.RecordId());
    end;
}
