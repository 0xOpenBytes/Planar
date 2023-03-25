import Plugin
import SpriteKit

#if os(macOS)
public typealias PlanarColor = NSColor
#else
public typealias PlanarColor = UIColor
#endif

/// A protocol that defines methods for creating various types of `PlanarNode`s.
public protocol PlanarNodeProducing {

    // MARK: - Node

    /// Creates a new instance of `PlanarNode` with the given plugins.
    ///
    /// - Parameter plugins: An array of plugins to apply to the node.
    ///
    /// - Returns: A new instance of `PlanarNode`.
    func node(
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a new instance of `PlanarNode` by loading a node graph from a file.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load.
    ///   - plugins: An array of plugins to apply to the node.
    ///
    /// - Returns: A new instance of `PlanarNode` if the file was successfully loaded, `nil` otherwise.
    func node(
        fileNamed: String,
        plugins: [any Plugin]
    ) -> PlanarNode?

    /// Creates a new instance of `PlanarNode` by loading a node graph from a file.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load.
    ///   - securelyWithClasses: A set of classes that the file is allowed to reference.
    ///   - plugins: An array of plugins to apply to the node.
    ///
    /// - Returns: A new instance of `PlanarNode` if the file was successfully loaded, throws an error otherwise.
    func node(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin]
    ) throws -> PlanarNode

    // MARK: - Shape

    /// Creates a new instance of `PlanarNode` representing a box shape.
    ///
    /// - Parameters:
    ///   - origin: The position of the center of the box.
    ///   - size: The size of the box.
    ///   - hasPhysics: Whether or not the box has physics applied to it.
    ///   - plugins: An array of plugins to apply to the node.
    ///
    /// - Returns: A new instance of `PlanarNode`.
    func box(
        origin: CGPoint,
        size: CGSize,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a rectangular box with the specified origin, size, and corner radius.
    /// - Parameters:
    ///   - origin: The origin point of the box in the coordinate system.
    ///   - size: The size of the box.
    ///   - cornerRadius: The radius of the corners of the box. A value of 0 will create a rectangle without rounded corners.
    ///   - hasPhysics: A Boolean value that determines whether the box has physics properties or not.
    ///   - plugins: An array of plugins that should be added to the box.
    ///
    /// - Returns: A `PlanarNode` object representing the created box.
    func box(
        origin: CGPoint,
        size: CGSize,
        cornerRadius: CGFloat,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a circular shape with the specified origin and diameter.
    /// - Parameters:
    ///   - origin: The origin point of the circle in the coordinate system.
    ///   - diameter: The diameter of the circle.
    ///   - hasPhysics: A Boolean value that determines whether the circle has physics properties or not.
    ///   - plugins: An array of plugins that should be added to the circle.
    ///
    /// - Returns: A `PlanarNode` object representing the created circle.
    func circle(
        origin: CGPoint,
        diameter: CGFloat,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates an elliptical shape with the specified origin and dimensions.
    /// - Parameters:
    ///   - origin: The origin point of the ellipse in the coordinate system.
    ///   - diameter: The size of the ellipse, specified as a `CGSize`.
    ///   - hasPhysics: A Boolean value that determines whether the ellipse has physics properties or not.
    ///   - plugins: An array of plugins that should be added to the ellipse.
    ///
    /// - Returns: A `PlanarNode` object representing the created ellipse.
    func ellipse(
        origin: CGPoint,
        diameter: CGSize,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a shape with the specified path.
    /// - Parameters:
    ///   - path: A `CGPath` object representing the path of the shape.
    ///   - hasPhysics: A Boolean value that determines whether the shape has physics properties or not.
    ///   - plugins: An array of plugins that should be added to the shape.
    ///
    /// - Returns: A `PlanarNode` object representing the created shape.
    func shape(
        path: CGPath,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode


    // MARK: - Sprite

    /// Creates a sprite with a solid color and a given size
    ///
    /// - Parameters:
    ///   - color: The color of the sprite
    ///   - size: The size of the sprite
    ///   - hasPhysics: Whether or not the sprite should have physics properties
    ///   - plugins: An array of plugins to apply to the sprite
    ///
    /// - Returns: A new PlanarNode sprite
    func sprite(
        color: PlanarColor,
        size: CGSize,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode

    // Creates a sprite with an image file and a given size
    ///
    /// - Parameters:
    ///   - imageNamed: The name of the image file to use for the sprite
    ///   - size: The size of the sprite
    ///   - normalMapped: Whether or not the sprite should use normal mapping
    ///   - hasPhysics: Whether or not the sprite should have physics properties
    ///   - plugins: An array of plugins to apply to the sprite
    ///
    /// - Returns: A new PlanarNode sprite
    func sprite(
        imageNamed: String,
        size: CGSize,
        normalMapped: Bool,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a sprite with a texture and a given size
    ///
    /// - Parameters:
    ///   - texture: The texture to use for the sprite
    ///   - size: The size of the sprite
    ///   - normalMap: The normal map texture to use for the sprite
    ///   - hasPhysics: Whether or not the sprite should have physics properties
    ///   - plugins: An array of plugins to apply to the sprite
    ///
    /// - Returns: A new PlanarNode sprite
    func sprite(
        texture: SKTexture,
        size: CGSize,
        normalMap: SKTexture?,
        hasPhysics: Bool,
        plugins: [any Plugin]
    ) -> PlanarNode

    // MARK: - Camera

    /// Creates a new PlanarNode that represents a camera.
    ///
    /// - Parameter plugins: An array of `Plugin` objects to attach to the camera.
    ///
    /// - Returns: A new PlanarNode instance that represents a camera.
    func camera(plugins: [any Plugin]) -> PlanarNode

    /// Creates a new PlanarNode from a serialized `.scn` file that represents a camera.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the `.scn` file to load from the app bundle.
    ///   - plugins: An array of `Plugin` objects to attach to the camera.
    ///
    /// - Returns: A new PlanarNode instance that represents a camera, or `nil` if the file could not be loaded.
    func camera(
        fileNamed: String,
        plugins: [any Plugin]
    ) -> PlanarNode?

    /// Creates a new PlanarNode from a serialized `.scn` file that represents a camera.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the `.scn` file to load from the app bundle.
    ///   - securelyWithClasses: A set of `AnyHashable` classes that can be used to safely unarchive the `.scn` file.
    ///   - plugins: An array of `Plugin` objects to attach to the camera.
    ///
    /// - Throws: An error if the file could not be loaded or unarchived securely.
    ///
    /// - Returns: A new PlanarNode instance that represents a camera.
    func camera(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin]
    ) throws -> PlanarNode

    // MARK: - Label

    /// Creates a PlanarNode with a UILabel displaying the given text.
    ///
    /// - Parameters:
    ///   - text: The text to display.
    ///   - plugins: An array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance with a UILabel displaying the given
    func label(
        text: String?,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a PlanarNode with a UILabel using the given fontNamed.
    ///
    /// - Parameters:
    ///   - fontNamed: The font name to use for the UILabel.
    ///   - plugins: An array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance with a UILabel using the given fontNamed.
    func label(
        fontNamed: String?,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a PlanarNode with a UILabel displaying the given NSAttributedString.
    ///
    /// - Parameters:
    ///   - attributedText: The attributed text to display.
    ///   - plugins: An array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance with a UILabel displaying the given NSAttributedString.
    func label(
        attributedText: NSAttributedString?,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a PlanarNode with a UILabel using the contents of the file at the given path.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file containing the UILabel contents.
    ///   - plugins: An array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance with a UILabel using the contents of the file at the given path.
    func label(
        fileNamed: String,
        plugins: [any Plugin]
    ) -> PlanarNode?

    /// Creates a PlanarNode with a UILabel using the contents of the file at the given path, subject to runtime
    /// security checks.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file containing the UILabel contents.
    ///   - securelyWithClasses: The set of allowed classes that can be used when loading the label file.
    ///   - plugins: An array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance with a UILabel using the contents of the file at the given path.
    ///
    /// - Throws: An error if the loaded file does not pass the runtime security checks.
    func label(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin]
    ) throws -> PlanarNode

    // MARK: - Audio

    /// Creates a new PlanarNode instance representing an audio object with no URL.
    ///
    /// - Parameters:
    ///   - plugins: An optional array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance representing an audio object with no URL.
    func audio(plugins: [any Plugin]) -> PlanarNode

    /// Creates a new PlanarNode instance representing an audio object with the specified URL.
    ///
    /// - Parameters:
    ///   - url: The URL of the audio file.
    ///   - plugins: An optional array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance representing an audio object with the specified URL.
    func audio(
        url: URL,
        plugins: [any Plugin]
    ) -> PlanarNode

    /// Creates a new PlanarNode instance representing an audio object with the specified file name.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the audio file.
    ///   - plugins: An optional array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance representing an audio object with the specified file name, or nil if the file cannot be found.
    func audio(
        fileNamed: String,
        plugins: [any Plugin]
    ) -> PlanarNode?

    /// Creates a new PlanarNode instance representing an audio object with the specified file name, securely checking for classes in the bundle to mitigate against class injection attacks.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the audio file.
    ///   - securelyWithClasses: A set of classes that are allowed to be loaded from the bundle.
    ///   - plugins: An optional array of plugins to attach to the node.
    ///
    /// - Returns: A new PlanarNode instance representing an audio object with the specified file name, or throws an error if the file cannot be found or if a class injection attack is detected.
    func audio(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin]
    ) throws -> PlanarNode

    // MARK: - Light

    /// Creates a PlanarNode with a light component.
    ///
    /// - Parameters:
    /// - plugins: An array of any Plugin objects that should be attached to the node.
    ///
    /// - Returns: A PlanarNode with a light component.
    func light(plugins: [any Plugin]) -> PlanarNode

    /// Creates a PlanarNode with a light component and loads the component data from a file.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load the light component data from.
    ///   - plugins: An array of any Plugin objects that should be attached to the node.
    ///
    /// - Returns: A PlanarNode with a light component, or nil if the file couldn't be loaded.
    func light(
        fileNamed: String,
        plugins: [any Plugin]
    ) -> PlanarNode?

    /// Creates a PlanarNode with a light component and securely loads the component data from a file.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load the light component data from.
    ///   - securelyWithClasses: A set of classes that the file is allowed to reference during loading.
    ///   - plugins: An array of any Plugin objects that should be attached to the node.
    ///
    /// - Throws: PluginError.invalidBundle if the bundle couldn't be loaded, or PluginError.fileNotFound if the file couldn't be found.
    ///
    /// - Returns: A PlanarNode with a light component.
    func light(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin]
    ) throws -> PlanarNode

    // MARK: - Video

    /// Creates a PlanarNode that represents a generic video player node. This node
    /// can play video from a file or URL.
    ///
    /// - Parameter plugins: An array of `Plugin` objects to add to the node.
    ///
    /// - Returns: A new instance of `PlanarNode` representing the video player node.
    func video(plugins: [any Plugin]) -> PlanarNode

    /// Creates a PlanarNode that represents a video player node using a specific
    /// video file.
    ///
    /// - Parameters:
    ///   - url: The URL of the video file.
    ///   - plugins: An array of `Plugin` objects to add to the node.
    ///
    /// - Returns: A new instance of `PlanarNode` representing the video player node.
    func video(
            url: URL,
            plugins: [any Plugin]
        ) -> PlanarNode

    /// Creates a PlanarNode that represents a video player node using a specific
    /// video file name.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the video file.
    ///   - plugins: An array of `Plugin` objects to add to the node.
    ///
    /// - Returns: A new instance of `PlanarNode` representing the video player node.
    func video(
            fileNamed: String,
            plugins: [any Plugin]
        ) -> PlanarNode?

    /// Creates a PlanarNode that represents a video player node using a specific
    /// video file name securely with a set of classes.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the video file.
    ///   - securelyWithClasses: A set of `AnyHashable` classes.
    ///   - plugins: An array of `Plugin` objects to add to the node.
    ///
    /// - Returns: A new instance of `PlanarNode` representing the video player node.
    func video(
            fileNamed: String,
            securelyWithClasses: Set<AnyHashable>,
            plugins: [any Plugin]
        ) throws -> PlanarNode


    // MARK: - Effect

    /// Creates a new `PlanarNode` that represents an effect node. The `plugins`
    /// parameter can be used to add any number of plugins to the effect node.
    ///
    /// - Parameter plugins: The plugins to add to the effect node.
    ///
    /// - Returns: A new `PlanarNode` that represents an effect node.
    func effect(plugins: [any Plugin]) -> PlanarNode

    /// Loads a new `PlanarNode` from a file that represents an effect node. The
    /// `plugins` parameter can be used to add any number of plugins to the effect
    /// node.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load the `PlanarNode` from.
    ///   - plugins: The plugins to add to the effect node.
    ///
    /// - Returns: A new `PlanarNode` that represents an effect node, or `nil` if
    ///   the file could not be loaded.
    func effect(
        fileNamed: String,
        plugins: [any Plugin]
    ) -> PlanarNode?

    /// Loads a new `PlanarNode` from a file that represents an effect node. The
    /// `plugins` parameter can be used to add any number of plugins to the effect
    /// node. The `securelyWithClasses` parameter can be used to restrict the
    /// types of classes that can be loaded from the file.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load the `PlanarNode` from.
    ///   - securelyWithClasses: The set of classes that are allowed to be loaded
    ///     from the file.
    ///   - plugins: The plugins to add to the effect node.
    ///
    /// - Throws: An error if the file could not be loaded or if any of the classes
    ///   loaded from the file are not allowed by the `securelyWithClasses`
    ///   parameter.
    ///
    /// - Returns: A new `PlanarNode` that represents an effect node.
    func effect(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin]
    ) throws -> PlanarNode


    // MARK: - Emitter

    /// Creates a new `PlanarNode` instance that represents an `SKEmitterNode`.
    ///
    /// - Parameter plugins: The plugins to attach to the emitter node.
    ///
    /// - Returns: A new `PlanarNode` instance that represents an `SKEmitterNode`.
    func emitter(plugins: [any Plugin]) -> PlanarNode

    /// Loads an `SKEmitterNode` from a file and wraps it in a `PlanarNode` instance.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load the emitter from.
    ///   - plugins: The plugins to attach to the emitter node.
    ///
    /// - Returns: A new `PlanarNode` instance that represents the loaded `SKEmitterNode`.
    ///   Returns `nil` if the file cannot be found or cannot be loaded.
    func emitter(
        fileNamed: String,
        plugins: [any Plugin]
    ) -> PlanarNode?

    /// Loads an `SKEmitterNode` from a file and wraps it in a `PlanarNode` instance,
    /// but only if the file contains classes that are listed in the `securelyWithClasses`
    /// set. If the file does not contain any of the listed classes, an error will be thrown.
    ///
    /// - Parameters:
    ///   - fileNamed: The name of the file to load the emitter from.
    ///   - securelyWithClasses: A set of classes that must be present in the file.
    ///   - plugins: The plugins to attach to the emitter node.
    ///
    /// - Throws: An error if the file cannot be found, cannot be loaded, or does not contain
    ///           any of the listed classes.
    ///
    /// - Returns: A new `PlanarNode` instance that represents the loaded `SKEmitterNode`.
    func emitter(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin]
    ) throws -> PlanarNode

}
