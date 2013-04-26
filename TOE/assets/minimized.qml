import bb.cascades 1.0

// This is the file used for the SceneCover shown when the application
// is running in minimized mode on the running apps page.

// In the SceneCover the content property keyword has to be explicitly added
Container {
    objectName: "coverObj"
    Container {        
        layout: DockLayout {
        }
        background: Color.Black
        
        
        // A title is put on a dark background, it is pixelaligned in order
        // to get it to match the checkerd pattern in the background image.
        Container {
            
            bottomPadding: 31
                     
            Container {
                preferredWidth: 320
                preferredHeight: 250
                background: Color.create("#11111111")
                layout: DockLayout {
                }
                Label {                    
                    text: {
                        "  TIME\n" + "    ON\n" + "EARTH"
                    }
                    textStyle.color: Color.Green
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 10
                    multiline: true
                    textStyle.fontStyle: FontStyle.Default
                    translationX: 90.0
                    translationY: 20.0
                }
            }
        }
    }
}
