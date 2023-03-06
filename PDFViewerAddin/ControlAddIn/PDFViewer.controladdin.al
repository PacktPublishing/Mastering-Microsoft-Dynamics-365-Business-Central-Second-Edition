controladdin "PACKT PDF Viewer"
{
    Scripts = 'https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js', 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.3.122/pdf.min.js', 'JavaScript/script.js';
    StartupScript = 'JavaScript/Startup.js';
    StyleSheets = 'JavaScript/stylesheet.css';

    MinimumHeight = 1;
    MinimumWidth = 1;
    MaximumHeight = 2000;
    HorizontalStretch = true;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalShrink = true;
    event ControlAddinReady();
    event onView()
    procedure LoadPDF(PDFDocument: Text; IsFactbox: Boolean)
    procedure SetVisible(IsVisible: Boolean)
}