import c
import Plugin
import SpriteKit

/// A `SKNode` that can have plugins attached to it.
public class PlanarNode: SKNode, Pluginable {
    /// The underlying `SKNode` that the `PlanarNode` wraps.
    public var node: SKNode

    /// An array of plugins that are attached to the `PlanarNode`.
    public var plugins: [any Plugin] = []

    /// The position of the `PlanarNode`.
    public override var position: CGPoint {
        get { node.position }
        set { node.position = newValue }
    }

    /// Creates a new `PlanarNode` with the given `SKNode` and plugins.
    ///
    /// - Parameters:
    ///   - node: The `SKNode` to wrap with the `PlanarNode`.
    ///   - plugins: An optional array of plugins to attach to the `PlanarNode`.
    public init(
        node: SKNode,
        plugins: [any Plugin] = []
    ) {
        self.node = node
        self.plugins = plugins

        super.init()

        if let parent = node.parent {
            node.move(toParent: self)
            parent.addChild(self)
        } else {
            addChild(node)
        }
    }

    /// Required initializer that is not implemented.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PlanarNodeProducing

extension PlanarNode: PlanarNodeProducing { }

// MARK: - Node

extension PlanarNode {
    /// Executes the given closure with the `SKPhysicsBody` associated with the node.
    ///
    /// - Parameter usage: A closure that takes an optional `SKPhysicsBody` parameter and does not return a value.
    public func physics(usage: (SKPhysicsBody?) -> Void) {
        usage(node.physicsBody)
    }

    /// Returns the node casted to the specified type.
    ///
    /// - Parameter type: The type to which the node will be casted.
    ///
    /// - Returns: The node casted to the specified type, or `nil` if the node cannot be casted to the specified type.
    public func `as`<Node>(type: Node.Type = Node.self) -> Node? {
        node as? Node
    }

    /// Executes the given closure with the node casted to the specified type.
    ///
    /// - Parameters:
    ///   - type: The type to which the node will be casted.
    ///   - usage: A closure that takes an optional node of the specified type and does not return a value.
    public func use<Node>(as type: Node.Type = Node.self, usage: (Node?) -> Void) {
        usage(self.as(type: type))
    }

    /// Returns the node casted to the specified type, or throws an error if the node cannot be casted to the specified type.
    ///
    /// - Parameter type: The type to which the node will be casted.
    ///
    /// - Throws: An error of type `c.InvalidTypeError` if the node cannot be casted to the specified type.
    ///
    /// - Returns: The node casted to the specified type.
    public func resolve<Node>(type: Node.Type = Node.self) throws -> Node {
        guard let node = node as? Node else {
            throw c.InvalidTypeError(expectedType: Node.self, actualValue: self)
        }

        return node
    }

    /// Executes the given closure with the node casted to the specified type, or throws an error if the node cannot be casted to the specified type.
    ///
    /// - Parameters:
    ///   - type: The type to which the node will be casted.
    ///   - usage: A closure that takes a node of the specified type and does not return a value.
    ///   
    /// - Throws: An error of type `c.InvalidTypeError` if the node cannot be casted to the specified type.
    public func resolve<Node>(as type: Node.Type = Node.self, usage: (Node) -> Void) throws {
        usage(try resolve(type: type))
    }
}
