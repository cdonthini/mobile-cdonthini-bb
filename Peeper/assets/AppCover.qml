import bb.cascades 1.0

Container {
    Container {        
        layout: DockLayout {
        }
        background: Color.Black
        ImageView {
            imageSource: "asset:///png/sceneCover.png"
            scalingMethod: ScalingMethod.AspectFill
            opacity: 1.0
        }
       
        
    }
}
