package com.example.cheap_ride

import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/maps"


        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
            super.configureFlutterEngine(flutterEngine)
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                    call, result ->
                // This method is invoked on the main thread.
                // TODO
                if (call.method == "openmaps") {
                    System.out.println("hi")//call.arguments.toString())
                    var strUri : String? = call.argument("url")
                    println(strUri)

                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(strUri))
                    result.success(0)
                    intent.setClassName(
                        "com.google.android.apps.maps",
                        "com.google.android.maps.MapsActivity"
                    )

                    startActivity(intent)
//                    result.success(0)
//                val batteryLevel = getBatteryLevel()
//
//                if (batteryLevel != -1) {
//                    result.success(batteryLevel)
//                } else {
//                    result.error("UNAVAILABLE", "Battery level not available.", null)
//                }
                } else {
                    result.notImplemented()
                }
            }
        }


}
