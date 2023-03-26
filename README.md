# Planar

Planar is a library for building 2D games and simulations in Swift using SpriteKit. It provides a set of abstractions and utilities for organizing game objects, managing tasks, and handling input events.

## Usage

To use Planar, simply create a new scene and inherit from `PlanarScene`:

```swift
class GameScene: PlanarScene<GameSceneNodeKey> {
    // ...
}
```

Next, define a set of unique node keys using an enum:

```swift
enum GameSceneNodeKey: Hashable {
    case player(UInt)
    case enemy(UInt)
    case powerUp
}
```

You can then add nodes to the scene using the `add(node:forKey:)` method, passing in a key that matches one of your defined keys:

```swift
add(node: playerNode, forKey: .player(0))
add(node: enemyNode, forKey: .enemy(0))
add(node: powerUpNode, forKey: .powerUp)
```

To retrieve a node from the scene, use the `get(_:)` or `resolve(_:)` methods, passing in the appropriate key:

```swift
if let player = get(.player(0)) {
    // Do something with the player node
}
```

You can also create plugins to modify properties of nodes in a type-safe way. Here's an example:

```swift
struct PositionPlugin: Plugin {
    var keyPath: WritableKeyPath<PlanarNode, CGPoint>

    func handle(value: CGPoint, output: inout CGPoint) async throws {
        output = value
    }
}

let playerNode = PlanarNode(node: SKSpriteNode(imageNamed: "player"))
playerNode.register(plugin: PositionPlugin(keyPath: \.position))

try await playerNode.handle(value: CGPoint(x: 100, y: 100))

```

In this example, we create a `PositionPlugin` that modifies the `position` property of a `PlanarNode`. We then create a `PlanarNode` representing a player, and use the `handle` method to apply the `PositionPlugin` to set the player's position to (100, 100).
