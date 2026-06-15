package com.aidocumentscanner.pdfscanner.ocr.askpdf.smartcrop

import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.NativeAdFactory

class NativeAdFactoryMedium(
    private val layoutInflater: LayoutInflater,
) : NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: Map<String, Any>?,
    ): NativeAdView {
        val adView = layoutInflater.inflate(
            R.layout.native_ads_medium,
            null,
        ) as NativeAdView

        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        val iconView = adView.findViewById<ImageView>(R.id.ad_app_icon)
        val ctaView = adView.findViewById<TextView>(R.id.ad_call_to_action)
        val ctaLayout = adView.findViewById<LinearLayout>(R.id.buttonlayout)

        headlineView.text = nativeAd.headline

        val bodyText = nativeAd.body.orEmpty().trim()
        if (bodyText.isNotEmpty()) {
            bodyView.visibility = View.VISIBLE
            bodyView.text = bodyText
        } else {
            bodyView.visibility = View.GONE
        }

        val iconDrawable = nativeAd.icon?.drawable
        if (iconDrawable != null) {
            iconView.visibility = View.VISIBLE
            iconView.setImageDrawable(iconDrawable)
        } else {
            iconView.visibility = View.GONE
        }

        val ctaText = nativeAd.callToAction.orEmpty().trim()
        if (ctaText.isNotEmpty()) {
            ctaLayout.visibility = View.VISIBLE
            ctaView.text = ctaText
        } else {
            ctaLayout.visibility = View.GONE
        }

        adView.headlineView = headlineView
        adView.bodyView = bodyView
        adView.iconView = iconView
        adView.callToActionView = ctaView
        adView.mediaView = null
        adView.setNativeAd(nativeAd)

        return adView
    }
}
