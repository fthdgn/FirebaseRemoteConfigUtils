import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct RemoteConfigPropertyMCMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        RemoteConfigPropertyMCMacro.self,
    ]
}
