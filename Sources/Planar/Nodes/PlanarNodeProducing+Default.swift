import Plugin
import SpriteKit

// MARK: - Nodes

extension PlanarNodeProducing {
    public func node(plugins: [any Plugin] = []) -> PlanarNode {
        PlanarNode(
            node: SKNode(),
            plugins: plugins
        )
    }

    public func node(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func node(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}

// MARK: - Shapes

extension PlanarNodeProducing {
    public func box(
        origin: CGPoint,
        size: CGSize,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKShapeNode(
            rect: CGRect(
                origin: origin,
                size: size
            )
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        if hasPhysics {
            node.physicsBody = SKPhysicsBody(
                rectangleOf: size,
                center: CGPoint(
                    x: origin.x + size.width / 2,
                    y: origin.y + size.height / 2
                )
            )
        }

        return PlanarNode
    }

    public func box(
        origin: CGPoint,
        size: CGSize,
        cornerRadius: CGFloat,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKShapeNode(
            rect: CGRect(
                origin: origin,
                size: size
            ),
            cornerRadius: cornerRadius
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        if hasPhysics {
            node.physicsBody = SKPhysicsBody(
                polygonFrom: CGPath(
                    roundedRect: node.frame,
                    cornerWidth: cornerRadius,
                    cornerHeight: cornerRadius,
                    transform: nil
                )
            )
        }

        return PlanarNode
    }

    public func circle(
        origin: CGPoint,
        diameter: CGFloat,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKShapeNode(
            ellipseIn: CGRect(
                origin: origin,
                size: CGSize(width: diameter, height: diameter)
            )
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        if hasPhysics {
            let radius = diameter / 2

            node.physicsBody = SKPhysicsBody(
                circleOfRadius: radius,
                center: CGPoint(
                    x: origin.x + radius,
                    y: origin.y + radius
                )
            )
        }

        return PlanarNode
    }

    public func ellipse(
        origin: CGPoint,
        diameter: CGSize,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKShapeNode(
            ellipseIn: CGRect(
                origin: origin,
                size: diameter
            )
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        if hasPhysics {
            node.physicsBody = SKPhysicsBody(
                polygonFrom: CGPath(
                    ellipseIn: CGRect(
                        origin: origin,
                        size: diameter
                    ),
                    transform: nil
                )
            )
        }

        return PlanarNode
    }

    public func shape(
        path: CGPath,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKShapeNode(
            path: path
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        if hasPhysics {
            node.physicsBody = SKPhysicsBody(
                polygonFrom: path
            )
        }

        return PlanarNode
    }
}

// MARK: - Sprites

extension PlanarNodeProducing {
    public func sprite(
        color: PlanarColor,
        size: CGSize,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKSpriteNode(
            color: color,
            size: size
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        if hasPhysics {
            node.physicsBody = SKPhysicsBody(rectangleOf: size)
        }

        return PlanarNode
    }

    public func sprite(
        imageNamed: String,
        size: CGSize,
        normalMapped: Bool = false,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKSpriteNode(
            imageNamed: imageNamed,
            normalMapped: normalMapped
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        node.size = size

        if
            hasPhysics,
            let texture = node.texture
        {
            node.physicsBody = SKPhysicsBody(
                texture: texture,
                size: size
            )
        }

        return PlanarNode
    }

    public func sprite(
        texture: SKTexture,
        size: CGSize,
        normalMap: SKTexture? = nil,
        hasPhysics: Bool = true,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        let node = SKSpriteNode(
            texture: texture,
            normalMap: normalMap
        )

        let PlanarNode = PlanarNode(
            node: node,
            plugins: plugins
        )

        node.size = size

        if hasPhysics {
            node.physicsBody = SKPhysicsBody(
                texture: texture,
                size: size
            )
        }

        return PlanarNode
    }
}

// MARK: - Camera

extension PlanarNodeProducing {
    public func camera(plugins: [any Plugin] = []) -> PlanarNode  {
        PlanarNode(
            node: SKCameraNode(),
            plugins: plugins
        )
    }

    public func camera(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKCameraNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func camera(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKCameraNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}

// MARK: - Label

extension PlanarNodeProducing {
    public func label(
        text: String?,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        PlanarNode(
            node: SKLabelNode(text: text),
            plugins: plugins
        )
    }

    public func label(
        fontNamed: String?,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        PlanarNode(
            node: SKLabelNode(
                fontNamed: fontNamed
            ),
            plugins: plugins
        )
    }

    public func label(
        attributedText: NSAttributedString?,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        PlanarNode(
            node: SKLabelNode(
                attributedText: attributedText
            ),
            plugins: plugins
        )
    }

    public func label(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKLabelNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func label(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKLabelNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}

// MARK: - Audio

extension PlanarNodeProducing {
    public func audio(plugins: [any Plugin] = []) -> PlanarNode {
        PlanarNode(
            node: SKAudioNode(),
            plugins: plugins
        )
    }

    public func audio(
        url: URL,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        PlanarNode(
            node: SKAudioNode(url: url),
            plugins: plugins
        )
    }

    public func audio(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKAudioNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func audio(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKAudioNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}

// MARK: - Light

extension PlanarNodeProducing {
    public func light(plugins: [any Plugin] = []) -> PlanarNode {
        PlanarNode(
            node: SKLightNode(),
            plugins: plugins
        )
    }

    public func light(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKLightNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func light(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKLightNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}

// MARK: - Video

extension PlanarNodeProducing {
    public func video(plugins: [any Plugin] = []) -> PlanarNode {
        PlanarNode(
            node: SKVideoNode(),
            plugins: plugins
        )
    }

    public func video(
        url: URL,
        plugins: [any Plugin] = []
    ) -> PlanarNode {
        PlanarNode(
            node: SKVideoNode(url: url),
            plugins: plugins
        )
    }

    public func video(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKVideoNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func video(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKVideoNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}

// MARK: - Effect

extension PlanarNodeProducing {
    public func effect(plugins: [any Plugin] = []) -> PlanarNode {
        PlanarNode(
            node: SKEffectNode(),
            plugins: plugins
        )
    }

    public func effect(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKEffectNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func effect(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKEffectNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}

// MARK: - Emitter

extension PlanarNodeProducing {
    public func emitter(plugins: [any Plugin] = []) -> PlanarNode {
        PlanarNode(
            node: SKEmitterNode(),
            plugins: plugins
        )
    }

    public func emitter(
        fileNamed: String,
        plugins: [any Plugin] = []
    ) -> PlanarNode? {
        guard let node = SKEmitterNode(fileNamed: fileNamed) else { return nil }

        return PlanarNode(
            node: node,
            plugins: plugins
        )
    }

    public func emitter(
        fileNamed: String,
        securelyWithClasses: Set<AnyHashable>,
        plugins: [any Plugin] = []
    ) throws -> PlanarNode {
        PlanarNode(
            node: try SKEmitterNode(
                fileNamed: fileNamed,
                securelyWithClasses: securelyWithClasses
            ),
            plugins: plugins
        )
    }
}
