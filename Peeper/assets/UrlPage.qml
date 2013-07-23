import bb.cascades 1.0

Page {

    property variant nav
    property variant accountName
    property alias htmlContent: newsView.url
    titleBar: TitleBar {
        title: accountName
        visibility: ChromeVisibility.Visible

    }
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            id: linkHome
            title: qsTr("Access")
            onTriggered: {
                // show detail page when the button is clicked
                var page = getAccessPage();
                nav.push(page);
            }
            property Page accessPage
            function getAccessPage() {
                if (! accessPage) {
                    accessPage = accessPageDefinition.createObject();
                    accessPage.nav = nav;
                    accessPage.peepID = peepID;
                }
                return accessPage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: accessPageDefinition
                    source: "access.qml"
                }
            ]
        }

    }
    actionBarVisibility: ChromeVisibility.Default
    Container {
        layout: DockLayout {

        }
        ActivityIndicator {
            id: loadingID
            running: true
            preferredWidth: 200.0
            preferredHeight: 200.0
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center

            visible: {
                if (running) true;
                else false;
            }
        }

        ScrollView {
            id: scrollView

            scrollViewProperties {
                scrollMode: ScrollMode.Both
                minContentScale: 0.5
                maxContentScale: 3.0
                pinchToZoomEnabled: true
                overScrollEffectMode: OverScrollEffectMode.OnPinch
                initialScalingMethod: ScalingMethod.AspectFill
            }
            WebView {
                onLoadingChanged: {
                    if (loadRequest.status == WebLoadStatus.Succeeded) {
                        loadingID.running = false;
                    }

                }
                id: newsView
                settings.activeTextEnabled: true
                onMinContentScaleChanged: {
                    scrollView.scrollViewProperties.minContentScale = minContentScale;
                }

                onMaxContentScaleChanged: {
                    scrollView.scrollViewProperties.maxContentScale = maxContentScale;
                }
                settings.zoomToFitEnabled: true

            }
        }
    }
}