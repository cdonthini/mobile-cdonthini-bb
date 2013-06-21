import bb.cascades 1.0

Page {
    id: pinPage
    property variant nav
    property variant accountName
    property variant userName
    property variant passWord
    property variant tag
    property variant pk
    property int path

    titleBar: TitleBar {
        id: check
        title: qsTr("Pin")
        visibility: ChromeVisibility.Visible

    }

    Container {
        layoutProperties: StackLayoutProperties {

        }

        Label {
            text: qsTr("Enter Pin to view your Password")
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
            hintText: qsTr("Pin here")
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
                    pwPage.pk = pk;
                    pwPage.path = path;

                    pwPage.nav = nav;

                } 
                
                else if ( path != 786 && _app.checkPIN(enteredPIN.text) ){
                    pwPage = hpDefinition.createObject();
                    pwPage.nav = nav;
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
