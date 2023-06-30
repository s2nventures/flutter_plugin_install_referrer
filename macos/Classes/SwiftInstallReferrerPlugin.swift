import Cocoa
import FlutterMacOS
import Foundation
import Security

private var isDebug: Bool {
  #if DEBUG
    return true
  #else
    return false
  #endif
}

public class SwiftInstallReferrerPlugin: NSObject, FlutterPlugin, IRInstallReferrerInternalAPI {
    public static func register(with registrar: FlutterPluginRegistrar) {
    	let messenger: FlutterBinaryMessenger = registrar.messenger
        let api : IRInstallReferrerInternalAPI & NSObjectProtocol = SwiftInstallReferrerPlugin.init()
        IRInstallReferrerInternalAPISetup(messenger, api);
    }

    public func detectReferrer(completion: @escaping (IRIRInstallationReferer?, FlutterError?) -> Void) {
        let result = IRIRInstallationReferer.init()
        result.platform = IRIRPlatform.macos
        result.packageName = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        
        if (isDebug) {
            result.type = IRIRInstallationType.debug
            result.installationPlatform = IRIRInstallationPlatform.manually
        } else if (Bundle.main.isTestFlight) {
            result.type = IRIRInstallationType.test
            result.installationPlatform = IRIRInstallationPlatform.appleTestflight
        } else {
            result.type = IRIRInstallationType.appStore
            result.installationPlatform = IRIRInstallationPlatform.appleAppStore
        }
        
        completion(result, nil)
    }
}

extension Bundle {
    /// Returns whether the bundle was signed for TestFlight beta distribution by checking
    /// the existence of a specific extension (marker OID) on the code signing certificate.
    ///
    /// This routine is inspired by the source code from ProcInfo, the underlying library
    /// of the WhatsYourSign code signature checking tool developed by Objective-See. Initially,
    /// it checked the common name but was changed to an extension check to make it more
    /// future-proof.
    ///
    /// For more information, see the following references:
    /// - https://github.com/objective-see/ProcInfo/blob/master/procInfo/Signing.m#L184-L247
    /// - https://gist.github.com/lukaskubanek/cbfcab29c0c93e0e9e0a16ab09586996#gistcomment-3993808
    internal var isTestFlight: Bool {
        var status = noErr

        var code: SecStaticCode?
        status = SecStaticCodeCreateWithPath(bundleURL as CFURL, [], &code)

        guard status == noErr, let code = code else { return false }

        var requirement: SecRequirement?
        status = SecRequirementCreateWithString(
            "anchor apple generic and certificate leaf[field.1.2.840.113635.100.6.1.25.1]" as CFString,
            [], // default
            &requirement
        )

        guard status == noErr, let requirement = requirement else { return false }

        status = SecStaticCodeCheckValidity(
            code,
            [], // default
            requirement
        )

        return status == errSecSuccess
    }
}
