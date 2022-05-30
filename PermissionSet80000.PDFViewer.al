permissionset 80000 "PDFViewer"
{
    Assignable = true;
    Caption = 'PDFViewer', MaxLength = 30;
    Permissions =
        table "PDFV PDF Storage" = X,
        tabledata "PDFV PDF Storage" = RMID,
        page "PDFV PDF Viewer" = X,
        page "PDFV PDF Viewer Factbox" = X,
        page "PDFV PDF Storage" = X,
        page "PDFV PDF Viewer Matrix" = X,
        page "PDFV PDFViewerDocAttachament" = X;
}
