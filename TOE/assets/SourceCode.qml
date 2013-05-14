import bb.cascades 1.0

Page {
    id: sourcePage
    Container {
        layout: DockLayout {
        }

        // To enable scrolling in the WebView, it is put inside a ScrollView.
        ScrollView {

            // Scrolling is restricted to vertical direction only, in this particular case.
            scrollViewProperties {
                scrollMode: ScrollMode.Vertical
            }
            WebView {
                // The url that is loaded points to the QML of this recipe on GitHub.
                url: "https://github.com/cdonthini/mobile-cdonthini-bb/tree/master/TOE"
                onLoadProgressChanged: {
                    // Update the ProgressBar while loading.
                    progressIndicator.value = loadProgress / 100.0
                }
                onLoadingChanged: {
                    if (loadRequest.status == WebLoadStatus.Started) {
                        // Show the ProgressBar when loading started.
                        progressIndicator.opacity = 1.0
                    } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                        // Hide the ProgressBar when loading is complete.
                        progressIndicator.opacity = 0.0
                    } else if (loadRequest.status == WebLoadStatus.Failed) {
                        // If loading failed, fallback to inline HTML, by setting the HTML property directly.
                        html = "<html><head><title>Fallback HTML on Loading Failed</title><style>* { margin: 0px; padding 0px; }body { font-size: 48px; font-family: monospace; border: 1px solid #444; padding: 4px; }</style> </head> <body>Oh ooh, loading of the URL that was set on this WebView failed. Perhaps you are not connected to the Internet?</body></html>"
                        progressIndicator.opacity = 0.0
                    }
                }

                // This is the Navigation-requested signal handler so just print to console to illustrate usage.
                onNavigationRequested: {
                    console.debug("NavigationRequested: " + request.url + " navigationType=" + request.navigationType)
                }
            }
        } // ScrollView

        // A progress indicator that is used to show the loading status
        Container {
            bottomPadding: 25
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            ProgressIndicator {
                id: progressIndicator
                opacity: 0
            }
        }
    }
}
