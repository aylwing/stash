//
//  UIImageView+ImageDownloader.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/10/21.
//

import UIKit


// Usually better just to use a framework like `SDWebImage` or something that has: persistance, stale data invalidity baked in etc.

private var cache = NSCache<NSURL, UIImage>()

extension UIImageView {

    func downloadImageFrom(url: String, contentMode: UIView.ContentMode = .scaleAspectFill, didFinish: (() -> Void)? = nil) {
        guard let url = URL(string: url) else { return }
        return downloadImageFrom(url: url, didFinish: didFinish)
    }

    func downloadImageFrom(url: URL, contentMode: UIView.ContentMode = .scaleToFill, didFinish: (() -> Void)? = nil) {

        // If images don't change frequently they can be cached in a persistance layer and retrieved via URL before attempting to hit server.
        // Example: fetching can live within an interactor and treat UIImageView as any other view

        if let image = cache.object(forKey: url as NSURL) {
            self.image = image
            self.contentMode = contentMode
            return
        }

        // Example: Apples NSCache approach
        // https://developer.apple.com/documentation/uikit/uiimage/asynchronously_loading_images_into_table_and_collection_views

        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    cache.setObject(image, forKey: url as NSURL)
                    self.contentMode = contentMode
                    self.image = image
                    didFinish?()
                }

            }.resume()
        }
    }
}
