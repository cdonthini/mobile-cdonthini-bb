import bb.cascades 1.0

Container {
    Container {        
        layout: DockLayout {
        }
        background: Color.Black
        ImageView {

            scalingMethod: ScalingMethod.AspectFill
            opacity: 1.0
            imageSource: "asset:///images/icon.png"
        }

    }
}
