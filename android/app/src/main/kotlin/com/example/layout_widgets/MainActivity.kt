package com.example.layout_widgets

import android.annotation.SuppressLint
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import android.os.BatteryManager.BATTERY_PROPERTY_CAPACITY
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.RequiresApi
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices

class MainActivity: FlutterActivity() {

    lateinit var fusedLocationClient: FusedLocationProviderClient

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL_LOCATION)
            .setMethodCallHandler { call, result ->
                Log.d(TAG, "location_channel :: method ${call.method}")
                if (METHOD_CURRENT_LOCATION == call.method) {
                    getCurrentLocation(result)
                }
            }

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

    @SuppressLint("MissingPermission")
    private fun getCurrentLocation(result: MethodChannel.Result) {
        fusedLocationClient.lastLocation
            .addOnSuccessListener(this) { location ->
                val res = "(${location.latitude}, ${location.longitude})"
                Log.d(TAG, "location? $res")
                result.success(res)
            }
    }

    companion object {
        const val TAG = "PlatformChannels"
        const val METHOD_BATTERY = "getBatteryLevel";
        const val CHANNEL_BATTERY = "android/battery";
        const val METHOD_CURRENT_LOCATION = "getCurrentLocation"
        const val CHANNEL_LOCATION = "android/location"
    }
}
