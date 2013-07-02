import bb.cascades 1.0
import bb.cascades.multimedia 1.0
import bb.multimedia 1.0
Page {
    property variant nav

    Container {
        onCreationCompleted: {
            camera.open()
        }

        Camera {
            id: camera

            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

            onCameraOpened: {

                getSettings(cameraSettings);
                cameraSettings.flashMode = CameraFlashMode.Off;
                cameraSettings.cameraMode = CameraMode.Photo;
                cameraSettings.cameraRollPath = ".../accounts/1000/shared/camera/workoutTracker";
                applySettings(cameraSettings);
                camera.startViewfinder();

            }
            onTouch: {
                if (event.isDown()) camera.capturePhoto();
            }

            attachedObjects: [
                CameraSettings {
                    id: cameraSettings
                }
            ]
        }
    }
    actions: [
        ActionItem {
            ActionBar.placement: ActionBarPlacement.InOverflow
            id: flashMode
            title: qsTr("Flash")
            onTriggered: {
                camera.getSettings(cameraSettings);
                if (cameraSettings.flashMode == CameraFlashMode.Off) {
                    cameraSettings.flashMode = CameraFlashMode.On;
                    flashMode.imageSource("asset:///images/flashON.jpg")
                } else {
                    cameraSettings.flashMode = CameraFlashMode.Off;
                    
                    flashMode.imageSource("asset:///images/flashOFF.jpg")
                }
                camera.applySettings(cameraSettings);
            }
            imageSource : "asset:///images/flashOFF.jpg"
        },
        ActionItem {
            ActionBar.placement: ActionBarPlacement.InOverflow
            id: cameraUnit
            title: qsTr("Switch")
            onTriggered: {
                if (camera.cameraUnit == CameraUnit.Front) {
                    camera.close();
                    camera.open(CameraUnit.Rear);
                } else {
                    camera.close();
                    camera.open(CameraUnit.Front);
                }
            }
            imageSource: "asset:///images/switch.jpg"
        }
    ]

}
