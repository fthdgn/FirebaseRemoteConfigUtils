import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct RemoteConfigPropertyMCMacro: AccessorMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingAccessorsOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in _: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.AccessorDeclSyntax] {
        let key = try node.attribute(withKey: "key") ?? "\"\(try declaration.name())\""
        let fallback = try declaration.initializer() ?? "nil"
        
        return [
            """
            get {
                return FirebaseRemoteConfig.RemoteConfig.remoteConfig().getValue(
                    forKey: \(raw: key),
                    withFallback: \(raw: fallback)
                )
            }
            """,
        ]
    }
}

extension SwiftSyntax.DeclSyntaxProtocol {
    func name() throws -> String {
        guard let variableDecl = self.as(VariableDeclSyntax.self) else {
            throw RemoteConfigPropertyMCMacroError.error("not variableDecl")
        }
        guard let identifier = variableDecl.bindings.first?.pattern.as(IdentifierPatternSyntax.self) else {
            throw RemoteConfigPropertyMCMacroError.error("not identifier")
        }
        let name = identifier.identifier.text
        return name
    }
    
    func initializer() throws -> String? {
        guard let variableDecl = self.as(VariableDeclSyntax.self) else {
            throw RemoteConfigPropertyMCMacroError.error("not variableDecl")
        }
        guard let identifier = variableDecl.bindings.first?.initializer?.as(InitializerClauseSyntax.self) else {
            return nil
        }
        return identifier.value.description.trimmingCharacters(in: .whitespaces)
    }
}

extension SwiftSyntax.AttributeSyntax {
    func attribute(withKey key: String) -> String? {
        let macroKey = arguments?.as(LabeledExprListSyntax.self)?.first(where: { $0.label?.text == key })
        return macroKey?.expression.formatted().description.trimmingCharacters(in: .whitespaces)
    }
}

enum RemoteConfigPropertyMCMacroError: Error {
    case error(String)
}
