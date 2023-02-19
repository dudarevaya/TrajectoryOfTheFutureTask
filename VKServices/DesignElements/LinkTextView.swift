//
//  LinkTextView.swift
//  VKServices
//
//  Created by Yana Dudareva on 19.02.2023.
//

import UIKit

class LinkTextView: UITextView, UITextViewDelegate {
    
    typealias Links = [String: String]
    
    typealias OnLinkTap = (URL) -> Bool
    
    var onLinkTap: OnLinkTap?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isEditable = false
        isSelectable = true
        isScrollEnabled = false 
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addLinks(_ links: Links) {
        guard attributedText.length > 0  else {
            return
        }
        let mText = NSMutableAttributedString(attributedString: attributedText)
        
        for (linkText, urlString) in links {
            if linkText.count > 0 {
                let linkRange = mText.mutableString.range(of: linkText)
                mText.addAttribute(.link, value: urlString, range: linkRange)
            }
        }
        attributedText = mText
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return onLinkTap?(URL) ?? true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.selectedTextRange = nil
    }
}
