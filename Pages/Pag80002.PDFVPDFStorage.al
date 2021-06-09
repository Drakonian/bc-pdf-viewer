page 80002 "PDFV PDF Storage"
{

    ApplicationArea = All;
    Caption = 'PDF Storage';
    PageType = List;
    SourceTable = "PDFV PDF Storage";
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(PDFViewerFactbox; "PDFV PDF Viewer Factbox")
            {
                ApplicationArea = All;
                Caption = 'View';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UploadContent)
            {
                ApplicationArea = All;
                Image = MoveUp;
                Caption = 'Upload';
                ToolTip = 'Upload';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PDFStorage: Record "PDFV PDF Storage";
                    SourceRecordID: RecordId;
                begin
                    if Rec.GetFilter("Source Record ID") <> '' then
                        Evaluate(SourceRecordID, Rec.GetFilter("Source Record ID"));
                    PDFStorage.UploadContent(SourceRecordID);
                    CurrPage.Update(true);
                end;
            }

            action(DownloadContent)
            {
                ApplicationArea = All;
                Image = MoveDown;
                Caption = 'Download';
                ToolTip = 'Download';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.DownloadContent();
                    CurrPage.Update(true);
                end;
            }
        }

    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.Update(true);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.PDFViewerFactbox.Page.SetRecord(Rec."Entry No.");
    end;

}
