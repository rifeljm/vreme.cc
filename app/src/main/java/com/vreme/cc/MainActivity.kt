package com.vreme.cc

import android.annotation.SuppressLint
import android.content.res.Configuration
import android.os.Bundle
import android.os.PowerManager
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import android.view.WindowManager
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.ComponentActivity
import androidx.activity.enableEdgeToEdge
import androidx.activity.OnBackPressedCallback
import com.vreme.cc.BuildConfig

class MainActivity : ComponentActivity() {
    private lateinit var webView: WebView
    private var wakeLock: PowerManager.WakeLock? = null

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        
        // Enable WebView debugging in debug builds
        if (BuildConfig.DEBUG) {
            WebView.setWebContentsDebuggingEnabled(true)
        }

        // Make the activity fullscreen using modern API
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R) {
            window.insetsController?.let { controller ->
                controller.hide(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
                controller.systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            }
        } else {
            // Fallback for older versions
            @Suppress("DEPRECATION")
            window.setFlags(
                WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN
            )
            
            @Suppress("DEPRECATION")
            window.decorView.systemUiVisibility = (
                View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
            )
        }

        // Create and configure WebView
        webView = WebView(this)
        val settings = webView.settings
        settings.javaScriptEnabled = true
        settings.domStorageEnabled = true
        settings.loadWithOverviewMode = true
        settings.useWideViewPort = true
        settings.allowFileAccessFromFileURLs = true
        settings.allowUniversalAccessFromFileURLs = true
        
        // Disable all caching to always load fresh content
        settings.cacheMode = WebSettings.LOAD_NO_CACHE
        // Clear cache on startup
        webView.clearCache(true)
        webView.clearHistory()
        
        webView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
                return false
            }

            override fun onReceivedError(
                view: WebView?,
                errorCode: Int,
                description: String?,
                failingUrl: String?
            ) {
                android.util.Log.e("WebViewError", "${'$'}errorCode ${'$'}description @ ${'$'}failingUrl")
            }
        }

        // Load the website - always load fresh (no cache)
        webView.loadUrl("https://app.vreme.cc/")
        
        // Set WebView as content view
        setContentView(webView)
        
        // Keep screen on for 24/7 operation
        keepScreenOn()
        
        // Handle back button press using modern API
        onBackPressedDispatcher.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                if (webView.canGoBack()) {
                    webView.goBack()
                } else {
                    finish()
                }
            }
        })
    }
    
    @SuppressLint("WakelockTimeout")
    private fun keepScreenOn() {
        // Keep screen on using window flags
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        
        // Acquire wake lock to prevent device from sleeping
        val powerManager = getSystemService(POWER_SERVICE) as PowerManager
        wakeLock = powerManager.newWakeLock(
            PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
            "VremeCC::WeatherDisplay"
        )
        wakeLock?.acquire()
    }
    
    override fun onDestroy() {
        super.onDestroy()
        // Release wake lock when activity is destroyed
        wakeLock?.release()
        wakeLock = null
    }
    
    override fun onPause() {
        super.onPause()
        // Keep wake lock active even when paused for 24/7 operation
        // Don't release wake lock here
    }
    
    override fun onResume() {
        super.onResume()
        // Ensure wake lock is still active
        if (wakeLock?.isHeld != true) {
            keepScreenOn()
        }
        // Reload to get fresh content (bypass cache)
        webView.reload()
    }
    
    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        // Handle orientation change without recreating activity
        // The WebView will automatically adjust to the new orientation
        if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
            // WebView will handle the rotation automatically
        }
    }
}