package com.example.hpweather  // your package name

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.widget.ImageView
import android.widget.RemoteViews
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.AppWidgetTarget
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.URL

import android.os.Handler
import android.os.Looper

class HomeScreenWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        var tem = 1
        val handler = Handler(Looper.getMainLooper())
        val run = object : Runnable {
            override fun run() {
                appWidgetIds.forEach { widgetId ->
                    val views = RemoteViews(context.packageName, R.layout.widget_layout)

                    // Open App on Widget Click
                    val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                        context,
                        MainActivity::class.java
                    )
                    views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                    val icon = widgetData.getString("_icon", "")
                    val city = widgetData.getString("_cityName", "")
                    val temp = widgetData.getString("_temp", "")

                    tem++

                    views.setTextViewText(R.id.temp, tem.toString())
                    views.setTextViewText(R.id.cityName, city)
                    GlobalScope.launch {
                        val bitmap = icon?.let { loadImageFromUrl("https:" + icon) }
                        withContext(Dispatchers.Main) {
                            views.setImageViewBitmap(R.id.image_icon, bitmap)
                            appWidgetManager.updateAppWidget(widgetId, views)
                        }
                    }
                    appWidgetManager.updateAppWidget(widgetId, views)
                }
                handler.postDelayed(this, 4000)// 4 seconds
            }

        }
        handler.post(run)

    }


    private suspend fun loadImageFromUrl(imageUrl: String): Bitmap? {
        return try {
            val url = URL(imageUrl)
            val connection = url.openConnection()
            connection.connect()
            val input = connection.getInputStream()
            BitmapFactory.decodeStream(input)
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }

}