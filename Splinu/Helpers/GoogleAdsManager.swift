//
//  GoogleAdsManager.swift
//  LevelUpGames
//
//  Created by 1 on 14.10.2021.
//

import GoogleMobileAds

class GoogleAdsManager: NSObject, GADBannerViewDelegate {
    
    static let shared = GoogleAdsManager()
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

extension UIViewController {
    func addBunnerAddToBottom(adUnitID: String) {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        
        self.view.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bannerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            bannerView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = self
        
        bannerView.load(GADRequest())
        
        bannerView.delegate = GoogleAdsManager.shared
    }
}
