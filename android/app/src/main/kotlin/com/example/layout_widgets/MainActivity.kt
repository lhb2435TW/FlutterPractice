package com.example.layout_widgets

import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import android.os.BatteryManager.BATTERY_PROPERTY_CAPACITY
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.annotation.RequiresApi

class MainActivity: FlutterActivity() {

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL_BATTERY)
            .setMethodCallHandler { call, result ->
                if (METHOD_BATTERY == call.method) {
                    val manager = getSystemService(BATTERY_SERVICE) as BatteryManager
                    val battery = manager.getIntProperty(BATTERY_PROPERTY_CAPACITY)
                    result.success(battery)
                }
                result.notImplemented()
            }
    }

    companion object {
        const val METHOD_BATTERY = "getBatteryLevel";
        const val CHANNEL_BATTERY = "android/battery";
    }
}
