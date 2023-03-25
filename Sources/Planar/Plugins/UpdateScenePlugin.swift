import Cache
import Plugin
import SpriteKit

/// A plugin that updates all nodes in the `PlanarScene` with their own plugins.
public struct UpdateScenePlugin<NodeKey: Hashable>: Plugin {
    /// The key path to the cache of nodes in the `PlanarScene`.
    public var keyPath: WritableKeyPath<PlanarScene<NodeKey>, Cache<NodeKey, PlanarNode>>

    /// Initializes the plugin with a default key path to the cache of nodes in the `PlanarScene`.
    public init() {
        self.keyPath = \.nodes
    }

    /// Updates all nodes in the `PlanarScene` with their own plugins.
    ///
    /// - Parameters:
    ///   - value: The time interval since the last update.
    ///   - output: The cache of nodes in the scene.
    public func handle(value: TimeInterval, output: inout Cache<NodeKey, PlanarNode>) async throws {
        try await output.allValues.asyncForEach {
            try await $0.value.handle(value: value)
        }
    }
}
