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
            property bool photoBeingTaken;
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

            onCameraOpened: {

                getSettings(cameraSettings);
                cameraSettings.flashMode = CameraFlashMode.Off;
                cameraSettings.cameraMode = CameraMode.Photo;
                
                applySettings(cameraSettings);
                camera.startViewfinder();
            }
            onTouch: {
                if (photoBeingTaken == false) {
                    photoBeingTaken = true;
                    camera.capturePhoto();
                    shutterSound.play();
                }	
            }
            onViewfinderStarted: {
                photoBeingTaken = false;
            }
            onPhotoSaved: {
                photoBeingTaken = false;
                
            }
            attachedObjects: [
                CameraSettings {
                    id: cameraSettings
                    cameraRollPath: ".../accounts/1000/shared/documents"
                },
                SystemSound {
                    id: shutterSound
                    sound: SystemSound.CameraShutterEvent
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
            //imageSource : "asset:///images/flashOFF.jpg"
        },
        ActionItem {
            ActionBar.placement: ActionBarPlacement.InOverflow
            id: chooseUnit
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
