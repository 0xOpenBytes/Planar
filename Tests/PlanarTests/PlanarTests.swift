import XCTest
import SpriteKit
@testable import Planar

import Plugin

final class PlanarTests: XCTestCase {
    func testPlanarNode() throws {
        enum NodeKey {
            case camera
        }

        let scene = PlanarScene<NodeKey>()

        XCTAssertEqual(scene.nodes.allValues.count, 0)

        scene.add(node: scene.camera(), forKey: .camera)

        XCTAssertEqual(scene.nodes.allValues.count, 1)

        let camera: PlanarNode = try XCTUnwrap(scene.get(.camera))

        XCTAssertNoThrow(
            try camera.resolve(type: SKCameraNode.self)
        )

        let cameraNode = try XCTUnwrap(
            camera.as(type: SKCameraNode.self)
        )

        XCTAssertEqual(cameraNode, try scene.resolve(.camera, type: SKCameraNode.self))

        scene.remove(.camera)

        XCTAssertEqual(scene.nodes.allValues.count, 0)
    }
}
