import RealityKit
import ARKit
import SwiftUI

struct TabletopView: View {
    
    var body: some View {
        RealityView { content in
            let anchor = AnchorEntity(world: [0, -1, -2])
            let box = ModelEntity(mesh: .generateBox(size: 0.2))
            box.position = [0, 0, 0]
            anchor.addChild(box)
            content.add(anchor)
        }
    }
}

