import c
import Cache
import Plugin
import Scribe
import SpriteKit
import TaskManager

/// A custom `SKScene` that provides additional functionality for building 2D games and simulations in Swift using SpriteKit.
open class PlanarScene<NodeKey: Hashable>: SKScene, Pluginable {
    /// Represents a key for a task to be executed by the `TaskManager`.
    public enum TaskKey: Hashable {
        /// Represents a task to update the scene.
        case update(TimeInterval)
    }

    /// Returns the default scribe label for the scene, which is the name of the scene class.
    private static var defaultScribeLabel: String {
        "\(Self.self)"
    }

    /// Returns the default plugins for the scene.
    private static func defaultPlugins() -> [any Plugin] {
        [
            UpdateScenePlugin<NodeKey>()
        ]
    }

    /// The `TaskManager` instance used to manage tasks in the scene.
    public let taskManager: TaskManager<TaskKey>

    /// The cache of `PlanarNode` instances in the scene, indexed by node key.
    public var nodes: Cache<NodeKey, PlanarNode>

    /// The plugins attached to the scene.
    public var plugins: [any Plugin]

    /// The scribe instance used to log messages for the scene.
    public var scribe: Scribe

    /// Creates a new `PlanarScene` instance with default values.
    public override init() {
        taskManager = TaskManager()
        nodes = Cache()
        plugins = Self.defaultPlugins()
        scribe = Scribe(label: Self.defaultScribeLabel)

        super.init()

        scaleMode = .aspectFill
    }

    /// Creates a new `PlanarScene` instance with the given plugins and scribe instance.
    public init(
        plugins: [any Plugin],
        scribe: Scribe
    ) {
        taskManager = TaskManager()
        nodes = Cache()
        self.plugins = plugins
        self.scribe = scribe

        super.init()

        scaleMode = .aspectFill
    }

    /// Creates a new `PlanarScene` instance with the given size.
    public override init(size: CGSize) {
        taskManager = TaskManager()
        nodes = Cache()
        plugins = Self.defaultPlugins()
        scribe = Scribe(label: Self.defaultScribeLabel)

        super.init(size: size)

        scaleMode = .aspectFill
    }

    /// Creates a new `PlanarScene` instance from the given coder.
    required public init?(coder aDecoder: NSCoder) {
        taskManager = TaskManager()
        nodes = Cache()
        plugins = Self.defaultPlugins()
        scribe = Scribe(label: Self.defaultScribeLabel)

        super.init(coder: aDecoder)
    }

    /// Adds a PlanarNode to the scene with a given key.
    ///
    /// - Parameters:
    ///   - node: The PlanarNode to be added.
    ///   - key: The key to associate with the node.
    open func add(node: PlanarNode, forKey key: NodeKey) {
        nodes.set(value: node, forKey: key)

        node.name = "\(key)"

        addChild(node)
    }

    /// Removes the PlanarNode with the given key from the scene.
    ///
    /// - Parameter key: The key of the node to be removed.
    open func remove(_ key: NodeKey) {
        if let node = nodes.get(key) {
            node.removeFromParent()
        }

        nodes.remove(key)
    }

    /// Retrieves a PlanarNode from the scene with a given key.
    ///
    /// - Parameters:
    ///   - key: The key associated with the node.
    ///   - type: The type to cast the node as. Default is the PlanarNode type.
    ///
    /// - Returns: The PlanarNode with the given key, cast as the specified type.
    open func get<Node>(
        _ key: NodeKey,
        type: Node.Type = Node.self
    ) -> Node? {
        nodes.get(key)?.as(type: type)
    }

    /// Retrieves a PlanarNode from the scene with a given key.
    ///
    /// - Parameter key: The key associated with the node.
    ///
    /// - Returns: The PlanarNode with the given key.
    open func get(
        _ key: NodeKey
    ) -> PlanarNode? {
        nodes.get(key)
    }

    /// Retrieves a PlanarNode from the scene with a given key.
    ///
    /// - Parameter key: The key associated with the node.
    ///
    /// - Returns: The PlanarNode with the given key.
    open func childNode(
        _ key: NodeKey
    ) -> PlanarNode? {
        if let node = get(key) {
            return node
        }

        guard let node = childNode(withName: "\(key)") else {
            return nil
        }

        let planarNode = PlanarNode(node: node)
        nodes.set(value: planarNode, forKey: key)

        return planarNode
    }

    /// Resolves a PlanarNode from the scene with a given key.
    ///
    /// - Parameters:
    ///   - key: The key associated with the node.
    ///   - type: The type to cast the node as. Default is the PlanarNode type.
    ///
    /// - Returns: The resolved PlanarNode with the given key, cast as the specified type.
    ///
    /// - Throws: An error if the node cannot be resolved.
    open func resolve<Node>(
        _ key: NodeKey,
        type: Node.Type = Node.self
    ) throws -> Node {
        try nodes.resolve(key).resolve(type: type)
    }

    /// Resolves a PlanarNode from the scene with a given key.
    ///
    /// - Parameter key: The key associated with the node.
    ///
    /// - Returns: The resolved PlanarNode with the given key.
    ///
    /// - Throws: An error if the node cannot be resolved.
    open func resolve(
        _ key: NodeKey
    ) throws -> PlanarNode {
        try nodes.resolve(key)
    }

    /// Updates the scene with the given time interval.
    ///
    /// - Parameter currentTime: The current time of the scene.
    open override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        taskManager.task(key: .update(currentTime)) {
            try await self.handle(currentTime: currentTime)
        }
    }
}

// MARK: - PlanarNodeProducing

extension PlanarScene: PlanarNodeProducing { }

// MARK: - Private TaskKey Functions

extension PlanarScene {
    // MARK: update(TimeInterval)
    private func handle(currentTime: TimeInterval) async throws {
        try await handle(value: currentTime)
        taskManager.remove(.update(currentTime))
    }
}
