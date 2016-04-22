//
//  Extension.swift
//  RXMVHero
//
//  Created by Anak Mirasing on 4/7/16.
//  Copyright © 2016 iGROOMGRiM. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift
import Moya

extension String  {
    
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
}

extension Observable {
    func showErrorHUD() -> Observable<Element> {
        return self.doOn { event in
            switch event {
            case .Error(let e):
                // Unwrap underlying error
                guard let error = e as? Moya.Error else { throw e }
                guard case .StatusCode(let response) = error else { throw e }
                
                SVProgressHUD.showErrorWithStatus("Error \(response.statusCode)")
                
            default: break
            }
        }
    }
}

extension ViewController {
    
    func showLoadingHUD() {
        SVProgressHUD.show()
    }
    
    func hideLoadingHUD() {
        SVProgressHUD.dismiss()
    }
}