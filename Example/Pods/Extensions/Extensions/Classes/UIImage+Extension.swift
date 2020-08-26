//
//  UIImage+Extension.swift
//  Extensions
//
//  Created by Logic on 2019/11/13.
//

import Foundation
import ImageIO

public extension UIImage {
    
    var original: UIImage? {
        return self.withRenderingMode(.alwaysOriginal);
    }
    
    /// 用于私有库中获取私有库bundle中图片资源
    ///
    /// 使用示例：
    ///
    ///      UIImage.image(named: "", in: Bundle(for: type(of: self)))?.original
    ///      UIImage.image(color: UIColor.black)
    ///      UIImage.image(color: UIColor.black with:CGSize(width: 1, height: 1))
    ///
    /// - Parameter named: 图片名称
    /// - Parameter in: Bundle实例，Bundle(for: type(of: 私有库中的任意自定义类的实例))
    ///
    /// - Returns: 一张图片
    class func image(named imageName: String, in bundle: Bundle?) -> UIImage? {
        if let url = URL(string: bundle?.bundleIdentifier ?? "")
        {
            if let bundleURL = bundle?.url(forResource: url.pathExtension, withExtension: "bundle")
            {
                let imageBundle = Bundle(url: bundleURL)
                return UIImage(named: imageName, in: imageBundle, compatibleWith: nil)
            }
        }
        return nil
    }
    
    /// 创建指定尺寸纯色图片
    class func image(color: UIColor, with size:CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return theImage
    }
    
    class func image(color: UIColor) -> UIImage? {
        return self.image(color: color, with: CGSize(width: 1, height: 1))
    }
    
    /// 图片压缩 转自: https://swift.gg/2019/11/01/image-resizing 技巧 #3
    class func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height)
        ]

        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
        else {
            return nil
        }

        return UIImage(cgImage: image)
    }
    
    /// 获取图片指定位置图片
    class func imageCropping(_ image: UIImage?, in partRect:CGRect , with placeholder:UIImage?) -> UIImage? {
        guard let aImage = image else {
            return placeholder
        }
        guard let imageRef = aImage.cgImage else {
            return placeholder
        }
        guard let imagePartRef = imageRef.cropping(to: partRect) else {
            return placeholder
        }
        let partImage = UIImage.init(cgImage: imagePartRef)
        return partImage
    }
}
