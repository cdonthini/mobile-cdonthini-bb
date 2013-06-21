import bb.cascades 1.0
NavigationPane {
    id: mainNavig

    peekEnabled: false

    Page {
        property variant nav: mainNavig
        actionBarVisibility: ChromeVisibility.Hidden
        Container {

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                clipContentToBounds: false
                Container {
                    layout: DockLayout {
                        //orientation: LayoutOrientation.TopToBottom
                    }
                    horizontalAlignment: HorizontalAlignment.Fill
                    translationY: 0.0
                    ImageView {
                        imageSource: "asset:///png/Key-lock-chain-AG-large.jpg"

                        scalingMethod: ScalingMethod.AspectFill
                        loadEffect: ImageViewLoadEffect.Subtle
                        opacity: 0.5
                        visible: true
                        horizontalAlignment: HorizontalAlignment.Fill

                    }
                    Label {
                        text: qsTr("Enter a Peep ID comprised of digits to be used to access the app and view passwords to the stored accounts.")
                        multiline: true
                        textFormat: TextFormat.Plain
                        textStyle.color: Color.Black
                        textStyle.textAlign: TextAlign.Center
                        textStyle.fontSizeValue: 0.0
                        textStyle.fontSize: FontSize.Large
                    }
                }

                TextField {
                    id: enteredPIN

                    hintText: qsTr("Numeric Peep ID ###")
                    inputMode: TextFieldInputMode.NumericPassword
                    input.submitKey: SubmitKey.Submit

                    translationY: 20.0

                }
                TextField {
                    id: reenteredPIN

                    hintText: qsTr("Re-enter Numeric Peep ID ###")
                    inputMode: TextFieldInputMode.NumericPassword
                    input.submitKey: SubmitKey.Submit

                    translationY: 20.0
                    input {
                        onSubmitted: {
                            enterButton.clicked();
                        }
                    }
                }
                Container {
                    clipContentToBounds: false

                    horizontalAlignment: HorizontalAlignment.Center
                    Button {

                        id: enterButton
                        text: "Enter PeepID"
                        onClicked: {

                            var page = getHomePage();
                            mainNavig.push(page);
                        }
                        property Page homePage
                        function getHomePage() {
                            if (reenteredPIN.text == enteredPIN.text) {
                                if (! homePage && _app.createPIN(enteredPIN.text)) {
                                    homePage = homePageDefinition.createObject();
                                    homePage.nav = mainNavig;
                                }
                                return homePage;
                            } else {

                                _app.alert("Peep ID Mismatch!");
                                reenteredPIN.text = "";
                            }
                            
                        }
                        attachedObjects: [
                            ComponentDefinition {
                                id: homePageDefinition
                                source: "Home.qml"
                            }
                        ]
                        horizontalAlignment: HorizontalAlignment.Center
                        translationY: 20.0
                    }
                    Label {

                        text: "Note: Remember the entered Peep ID \n\n\n"
                        multiline: true
                        textFormat: TextFormat.Plain
                        textStyle.fontStyle: FontStyle.Italic
                        translationY: 20.0
                    }
                }
                Divider {
                }
                Container {
                    layout: StackLayout {

                    }

                    horizontalAlignment: HorizontalAlignment.Center

                    background: Color.Transparent
                    Label {
                        text: qsTr("Password Keeper")

                        textStyle.fontWeight: FontWeight.W900

                        textStyle.color: Color.Grey
                        textStyle.fontSize: FontSize.XXLarge
                        textStyle.fontStyle: FontStyle.Normal

                    }

                }

            }
        }

    }
}