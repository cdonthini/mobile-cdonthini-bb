import bb.cascades 1.0

Page {

    property variant nav
    property variant accountName
    property alias htmlContent: newsView.url
    titleBar: TitleBar {
        title: accountName 
    }
    Container {
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