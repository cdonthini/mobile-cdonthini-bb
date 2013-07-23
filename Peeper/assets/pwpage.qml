import bb.cascades 1.0

Page {

    id: passwordPage
    property variant nav
    property alias accountName: anText.text
    property alias userName: unText.text
    property variant passWord
    property variant tag
    property variant urlID
    property variant pk
    property int path
    property variant peepID

    titleBar: TitleBar {
        id: check
        title: qsTr("Account Details - ") + accountName
        visibility: ChromeVisibility.Default
        scrollBehavior: TitleBarScrollBehavior.NonSticky

    }

    onCreationCompleted: {
        Application.asleep.connect(onAsleep);
    }
    function onAsleep() {
        var pPage = pPageDefinition.createObject();
        //_app.alert("pwpage asleep");
        pPage.accountName = accountName;
        pPage.userName = userName;
        pPage.passWord = passWord;
        pPage.tag = tag;
        pPage.pk = pk;
        pPage.urlID = urlIDLabel.text;
        pPage.path = path;
        pPage.disableNavi = true;
        pPage.nav = nav;
        pPage.peepID = peepID;
        nav.push(pPage);
    }
    attachedObjects: [
        ComponentDefinition {
            id: pPageDefinition
            source: "Password.qml"
        }
    ]
    actionBarVisibility: ChromeVisibility.Hidden
    Container {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {

        }
        Container {
            visible: false
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            topPadding: 10.0
            Label {
                text: accountName

            }
            TextField {
                id: anText
                hintText: qsTr("Your Account name Here")
                inputMode: TextFieldInputMode.Text

                visible: false

            }
        }
        Container {
            topPadding: 20
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Label {
                text: "User Name: " + userName
                textStyle.fontSize: FontSize.Large
            }
            TextField {
                id: unText
                hintText: qsTr("Your Username Here")

                visible: false
                inputMode: TextFieldInputMode.EmailAddress
            }
        }
        Container {
            topPadding: 20
            Label {
                text: qsTr("Password:")
                visible: false
            }

            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }

            TextField {
                id: pwText
                text: _app.decryptPW(passWord.toString(), peepID.toString())

                hintText: qsTr("Your Password Here")
                inputMode: TextFieldInputMode.Password

            }
        }
        Label {
            id: tagText
            text: "Tags: " + tag + " "
        }
        Divider {

        }
        Container {
            topPadding: 10
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Center
            Button {
                id: copy
                text: qsTr("Copy Password")
                imageSource: "asset:///png/ic_copy_password.png"
                onClicked: {
                    _app.copyPassword(_app.decryptPW(passWord.toString(), peepID.toString()))
                }
            }
            Label {
                id: urlIDLabel
                text: urlID
                visible: false
            }
            Button {
                id: goURL
                text: qsTr("Go URL")
                imageSource: "asset:///png/ic_open.png"
                onClicked: {
                    _app.copyPassword(_app.decryptPW(passWord.toString(), peepID.toString()))
                    var page = getUrlPage();
                    nav.push(page);
                }
                property Page urlPage
                function getUrlPage() {
                    if (! urlPage) {
                        urlPage = urlPageDefinition.createObject();
                        urlPage.nav = nav;
                        urlPage.accountName = accountName;
                        urlPage.htmlContent = "http://" + urlIDLabel.text;
                    }
                    return urlPage;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: urlPageDefinition
                        source: "UrlPage.qml"
                    }
                ]
            }

        }
        Divider {

        }
        Button {
            imageSource: "//assets/png/icon_home.png"
            horizontalAlignment: HorizontalAlignment.Center
            topMargin: 25.0
            text: qsTr("Home")

            onClicked: {
                var page = getHomePage();
                nav.push(page);
            }
            property Page homePage
            function getHomePage() {
                if (! homePage) {
                    homePage = homePageDefinition.createObject();
                    homePage.nav = nav;
                    homePage.peepID = peepID;
                }
                return homePage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: homePageDefinition
                    source: "Home.qml"
                }
            ]
        }

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }

            horizontalAlignment: HorizontalAlignment.Center
            Button {
                imageSource: "//assets/png/ic_edit.png"
                id: editB
                text: qsTr("Update")

                onClicked: {
                    _app.modify(anText.text, unText.text, pwText.text, pk, peepID.toString());

                    var page = getAccessPage();
                    nav.push(page);
                }
                property Page accessPage
                function getAccessPage() {
                    if (! accessPage) {
                        accessPage = accessPageDefinitionEdit.createObject();
                        accessPage.accountName = accountName;
                        accessPage.userName = userName;
                        accessPage.passWord = pwText.text;
                        accessPage.urlIDtext = urlID;
                        accessPage.tag = tag;
                        accessPage.nav = nav;
                        accessPage.path = 1;
                        accessPage.pk = pk;
                        accessPage.peepID = peepID;
                    }
                    return accessPage;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: accessPageDefinitionEdit
                        source: "add.qml"
                    }
                ]

            }
            Button {

                text: qsTr("Remove")

                onClicked: {

                    _app.remove(pk);
                    _app.readRecords();
                    var page = getAccessPage();
                    nav.push(page);
                }
                property Page accessPage
                function getAccessPage() {
                    if (! accessPage) {
                        accessPage = accessPageDefinitionRemove.createObject();
                        accessPage.nav = nav;
                        accessPage.peepID = peepID;
                    }
                    return accessPage;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: accessPageDefinitionRemove
                        source: "access.qml"
                    }
                ]
                imageSource: "//assets/png/ic_delete.png"

            }
        }

    }
}
