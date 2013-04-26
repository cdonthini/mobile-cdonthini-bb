import bb.cascades 1.0

Page {
    id: yearPage
    property variant nav
    property variant yearname
    property variant monthnum
    property variant dayname
    titleBar: TitleBar {
        
        title: "Results"
    }
    Container {
        background: backgroundPaint.imagePaint
        attachedObjects: [
                ImagePaintDefinition {
                    id: backgroundPaint
                    imageSource: "asset:///images/background.amd"
                    repeatPattern: RepeatPattern.XY
                }
            ]
        Label {
            text: {
                "Year: " + yearname + "\n Month: " + monthnum + "\n Day: " + dayname
            }
            multiline: true
        }
        Divider {
        }
        Label {
            text: {
                var dmy = new Date();
                var days = ((30 - parseInt(dayname) ) + dmy.getDate() );
                var months = (12 - parseInt(monthnum)) + dmy.getMonth() + parseInt(days / 30);
                var years = dmy.getFullYear() - 1 - parseInt(yearname) + parseInt(months / 12);
                "You are \n" + years + " Years " + months % 12 + " Months " + days % 30 + " Days " + " old"
            }
            touchBehaviors: {
            }
            multiline: true
            horizontalAlignment: HorizontalAlignment.Center
            animations: [
                FadeTransition {
                    toOpacity: 1.0
                }
            ]
        }
        Divider {
        }
        Button {
            horizontalAlignment: HorizontalAlignment.Center
            
            text: "Start Over"
            onClicked: {
                // show detail page when the button is clicked
                var page = getHomePage();
                console.debug("pushing detail " + page)
                nav.push(page);
            }
            property Page homePage
            function getHomePage() {
                if (! homePage) {
                    homePage = homePageDefinition.createObject();
                    homePage.nav = nav;
                }
                return homePage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: homePageDefinition
                    source: "pickDay.qml"
                }
            ]
            translationY: 10.0
        }
    }
}
