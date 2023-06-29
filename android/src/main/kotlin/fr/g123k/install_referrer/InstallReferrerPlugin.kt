package fr.g123k.install_referrer

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** InstallReferrerPlugin */
class InstallReferrerPlugin : FlutterPlugin, MethodCallHandler,
    InstallReferrerPigeon.InstallReferrerInternalAPI {
    var context: Context? = null

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        InstallReferrerPigeon.InstallReferrerInternalAPI.setup(
            flutterPluginBinding.binaryMessenger,
            this
        )

        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        InstallReferrerPigeon.InstallReferrerInternalAPI.setup(
            binding.binaryMessenger,
            null
        )

        context = null
    }

    override fun detectReferrer(result: InstallReferrerPigeon.Result<InstallReferrerPigeon.IRInstallationReferer>) {
        context!!.run {
            val installerPackageName = packageManager.getInstallerPackageName(packageName)

            if (installerPackageName == null) {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.DEBUG,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.MANUALLY,
                    )
                )
            } else if (installerPackageName.startsWith("com.amazon")) {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.APP_STORE,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.AMAZON_APP_STORE,
                    )
                )
            } else if (installerPackageName == "com.android.vending") {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.APP_STORE,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.GOOGLE_PLAY,
                    )
                )
            } else if (installerPackageName == "com.huawei.appmarket") {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.APP_STORE,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.HUAWEI_APP_GALLERY,
                    )
                )
            } else if (installerPackageName == "com.sec.android.app.samsungapps") {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.APP_STORE,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.SAMSUNG_APP_SHOP,
                    )
                )
            } else if (installerPackageName == "com.oppo.market") {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.APP_STORE,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.OPPO_APP_MARKET,
                    )
                )
            } else if (installerPackageName == "com.vivo.appstore") {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.APP_STORE,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.VIVO_APP_STORE,
                    )
                )
            } else if (installerPackageName == "com.xiaomi.mipicks") {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.APP_STORE,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.XIAOMI_APP_STORE,
                    )
                )
            } else if (installerPackageName == "com.google.android.packageinstaller") {
                result.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.UNKNOWN,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.MANUALLY,
                    )
                )
            } else {
                result.error(Exception("Unknown installer $installerPackageName"))
            }
        }

    }

    private fun generateResult(
        type: InstallReferrerPigeon.IRInstallationType,
        platform: InstallReferrerPigeon.IRInstallationPlatform
    ): InstallReferrerPigeon.IRInstallationReferer {
        return InstallReferrerPigeon.IRInstallationReferer().apply {
            this.type = type
            this.packageName = context!!.packageName
            this.installationPlatform = platform
            this.platform = InstallReferrerPigeon.IRPlatform.ANDROID
        }
    }
}
