import bb.cascades 1.0

Page {
    id: pinPage
    property variant nav
    property variant accountName
    property variant userName
    property variant passWord
    property variant tag
    property variant urlID
    property variant pk
    property bool disableNavi
    property int path
    property variant peepID

    titleBar: TitleBar {
        id: check
        title: qsTr("Access Page")
        visibility: ChromeVisibility.Visible

    }

    actionBarVisibility: {
        	if(disableNavi){
        	    ChromeVisibility.Hidden
        	}
        	else ChromeVisibility.Overlay}
    Container {
        layoutProperties: StackLayoutProperties {

        }

        Label {
            text : {
                if (path == 786) {
                    "Enter Peep ID to view the account details:"
                }
                else {
                    "Enter Peep ID to access the app:"
                }
            }
            textStyle.fontSize: FontSize.Large
            multiline: true
            topMargin: 50.0
            enabled: false

        }

        TextField {
            id: enteredPIN
            inputMode: TextFieldInputMode.NumericPassword
            input.submitKey: SubmitKey.Submit
            topMargin: 50.0
            hintText: qsTr("Peep ID here")
            focusHighlightEnabled: true
            input {
                onSubmitted: {
                    submitButton.clicked();
                }
            }

        }

        Button {
            id: submitButton
            topMargin: 110.0
            text: qsTr("Submit")
            horizontalAlignment: HorizontalAlignment.Center
            minWidth: 500.0
            minHeight: 50.0
            onClicked: {

                var page = getPwPage();
                nav.push(page);
            }
            property Page pwPage
            function getPwPage() {
                if (! pwPage && _app.checkPIN(enteredPIN.text) && path == 786) {
                    _app.readRecords();
                    pwPage = pwPageDefinition.createObject();
                    pwPage.accountName = accountName;
                    pwPage.userName = userName;
                    pwPage.passWord = passWord;
                    pwPage.tag = tag;
                    pwPage.urlID = urlID;
                    pwPage.pk = pk;
                    pwPage.path = path;
                    pwPage.peepID = peepID;
                    pwPage.nav = nav;

                } 
                
                else if ( path != 786 && _app.checkPIN(enteredPIN.text) ){
                    pwPage = hpDefinition.createObject();
                    pwPage.nav = nav;
                    pwPage.peepID = enteredPIN.text;
                }
                return pwPage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: pwPageDefinition
                    source: "pwpage.qml"
                },
                ComponentDefinition {
                    id: hpDefinition
                    source: "Home.qml"
                }
            ]
            enabled: true
        }

    }
}
