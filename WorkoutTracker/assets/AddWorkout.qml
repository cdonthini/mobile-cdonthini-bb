import bb.cascades 1.0

Page {
    property variant nav
    property variant title
    Container {
        Label{
            text : title 
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontSize: FontSize.XLarge
            textStyle.fontWeight: FontWeight.W400
        }
        
    }
}
