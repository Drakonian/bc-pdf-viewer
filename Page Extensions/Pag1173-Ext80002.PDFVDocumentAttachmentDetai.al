pageextension 80002 "PDFV Document Attachment Detai" extends "Document Attachment Details" //1173
{
    actions
    {
        addlast(processing)
        {
            action("PDFV View PDF")
            {
                ApplicationArea = All;
                Image = Text;
                Caption = 'View PDF';
                ToolTip = 'View PDF';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = Rec."File Extension" = 'pdf';
                trigger OnAction()
                var
                    PDFViewerDocAttachment: Page "PDFV PDFViewerDocAttachament";
                begin
                    PDFViewerDocAttachment.SetRecord(Rec);
                    PDFViewerDocAttachment.SetTableView(Rec);
                    PDFViewerDocAttachment.Run();
                end;
            }
        }
    }
}
