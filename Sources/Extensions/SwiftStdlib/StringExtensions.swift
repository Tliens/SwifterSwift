//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// MARK: - Properties
public extension String {

    #if canImport(Foundation)
    /// base64Decoded
    ///
    ///		"SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    ///
    public var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }
    #endif

    #if canImport(Foundation)
    /// base64Encoded
    ///
    ///		"Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    ///
    public var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    #endif

    /// 转字符串数组
    public var charactersArray: [Character] {
        return Array(self)
    }

    #if canImport(Foundation)
    /// 字符串标准驼峰
    ///
    ///		"sOme vAriable naMe".camelCased -> "someVariableName"
    ///
    public var camelCased: String {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
    #endif

    /// 是否包含emoji
    ///
    ///		"Hello 😀".containEmoji -> true
    ///
    public var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }

    /// 第一个字符
    ///
    ///		"Hello".firstCharacterAsString -> Optional("H")
    ///		"".firstCharacterAsString -> nil
    ///
    public var firstCharacterAsString: String? {
        guard let first = first else { return nil }
        return String(first)
    }

    #if canImport(Foundation)
    /// 是否有字符
    ///
    ///		"123abc".hasLetters -> true
    ///		"123".hasLetters -> false
    ///
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    #endif

    #if canImport(Foundation)
    /// 是否有数字
    ///
    ///		"abcd".hasNumbers -> false
    ///		"123abc".hasNumbers -> true
    ///
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    #endif

    #if canImport(Foundation)
    /// 是否是字母
    ///
    ///		"abc".isAlphabetic -> true
    ///		"123abc".isAlphabetic -> false
    ///
    public var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    #endif

    #if canImport(Foundation)
    /// 是否是字母和数字
    ///
    ///		// useful for passwords
    ///		"123abc".isAlphaNumeric -> true
    ///		"abc".isAlphaNumeric -> false
    ///
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    #endif

    #if canImport(Foundation)
    /// 是否为有效的邮箱
    ///
    /// - Note: Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///		"john@doe.com".isValidEmail -> true
    ///
    public var isValidEmail: Bool {
        // http://emailregex.com/
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    #endif

    #if canImport(Foundation)
    /// 是否是有效的URL
    ///
    ///		"https://google.com".isValidUrl -> true
    ///
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    #endif

    #if canImport(Foundation)
    /// 是否为有效的 schemed URL.
    ///
    ///		"https://google.com".isValidSchemedUrl -> true
    ///		"google.com".isValidSchemedUrl -> false
    ///
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil
    }
    #endif

    #if canImport(Foundation)
    /// 是否是https
    ///
    ///		"https://google.com".isValidHttpsUrl -> true
    ///
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }
    #endif

    #if canImport(Foundation)
    /// 是否是http
    ///
    ///		"http://google.com".isValidHttpUrl -> true
    ///
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http"
    }
    #endif

    #if canImport(Foundation)
    /// 是否是有效的本地文件路径
    ///
    ///		"file://Documents/file.txt".isValidFileUrl -> true
    ///
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    #endif

    #if canImport(Foundation)
    /// 是否是数字
    ///
    /// Note:
    /// In North America, "." is the decimal separator,
    /// while in many parts of Europe "," is used,
    ///
    ///		"123".isNumeric -> true
    ///     "1.3".isNumeric -> true (en_US)
    ///     "1,3".isNumeric -> true (fr_FR)
    ///		"abc".isNumeric -> false
    ///
    public var isNumeric: Bool {
        let scanner = Scanner(string: self)
        scanner.locale = NSLocale.current
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    #endif

    #if canImport(Foundation)
    ///是否仅包含数字
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    public var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    #endif

    /// 最后一个字符
    ///
    ///		"Hello".lastCharacterAsString -> Optional("o")
    ///		"".lastCharacterAsString -> nil
    ///
    public var lastCharacterAsString: String? {
        guard let last = last else { return nil }
        return String(last)
    }

    #if canImport(Foundation)
    /// 拉丁字母转换.
    ///
    ///		"Hèllö Wórld!".latinized -> "Hello World!"
    ///
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    #endif

    #if canImport(Foundation)
    /// 是否可转换为有效的布尔值
    ///
    ///		"1".bool -> true
    ///		"False".bool -> false
    ///		"Hello".bool = nil
    ///
    public var bool: Bool? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "1":
            return true
        case "false", "0":
            return false
        default:
            return nil
        }
    }
    #endif

    #if canImport(Foundation)
    /// 字符串转时间 yyyy-MM-dd
    ///
    ///		"2007-06-29".date -> Optional(Date)
    ///
    public var date: Date? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    #endif

    #if canImport(Foundation)
    /// 字符串转时间 yyyy-MM-dd HH:mm:ss
    ///
    ///		"2007-06-29 14:23:09".dateTime -> Optional(Date)
    ///
    public var dateTime: Date? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    #endif

    /// 转Int
    ///
    ///		"101".int -> 101
    ///
    public var int: Int? {
        return Int(self)
    }

    /// 给定长度的伪文本。
    ///
    /// - Parameter length: number of characters to limit lorem ipsum to (default is 445 - full lorem ipsum).
    /// - Returns: Lorem ipsum dolor sit amet... string.
    public static func loremIpsum(ofLength length: Int = 445) -> String {
        guard length > 0 else { return "" }

        // https://www.lipsum.com/
        let loremIpsum = """
		Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		"""
        if loremIpsum.count > length {
            return String(loremIpsum[loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: length)])
        }
        return loremIpsum
    }

    #if canImport(Foundation)
    /// 从string创建URL
    ///
    ///		"https://google.com".url -> URL(string: "https://google.com")
    ///		"not url".url -> nil
    ///
    public var url: URL? {
        return URL(string: self)
    }
    #endif

    #if canImport(Foundation)
    /// 去掉首位的空格和换行
    ///
    ///		"   hello  \n".trimmed -> "hello"
    ///
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    #endif

    #if canImport(Foundation)
    /// 移除百分号编码
    ///
    ///		"it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    #endif

    #if canImport(Foundation)
    /// urlEncoded
    ///
    ///		"it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    #endif

    #if canImport(Foundation)
    /// 字符串没有空格和新行
    ///
    ///		"   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
    ///
    public var withoutSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    #endif

    #if canImport(Foundation)
    /// 检查是否有空格和换行
    public var isWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 检查给定的字符串拼写是否正确
    public var isSpelledCorrectly: Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: utf16.count)

        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: Locale.preferredLanguages.first ?? "en")
        return misspelledRange.location == NSNotFound
    }
    #endif

}

// MARK: - Methods
public extension String {

    #if canImport(Foundation)
    /// 转float
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Float value from given string.
    public func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self)?.floatValue
    }
    #endif

    #if canImport(Foundation)
    /// 转double
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Double value from given string.
    public func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self)?.doubleValue
    }
    #endif

    #if canImport(CoreGraphics) && canImport(Foundation)
    /// 转 CGFloat
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional CGFloat value from given string.
    public func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? CGFloat
    }
    #endif

    #if canImport(Foundation)
    /// 通过换行符拆分
    ///
    ///		"Hello\ntest".lines() -> ["Hello", "test"]
    ///
    /// - Returns: Strings separated by new lines.
    public func lines() -> [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    #endif

    #if canImport(Foundation)
    /// 返回本地化的字符串，并为翻译人员提供可选的注释。
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    #endif

    /// 字符串中最多的字符。
    ///
    ///		"This is a test, since e is appearing everywhere e should be the common character".mostCommonCharacter() -> "e"
    ///
    /// - Returns: The most common character.
    public func mostCommonCharacter() -> Character? {
        let mostCommon = withoutSpacesAndNewLines.reduce(into: [Character: Int]()) {
            let count = $0[$1] ?? 0
            $0[$1] = count + 1
            }.max { $0.1 < $1.1 }?.0

        return mostCommon
    }

    /// 所有字符的unicode
    ///
    ///		"SwifterSwift".unicodeArray() -> [83, 119, 105, 102, 116, 101, 114, 83, 119, 105, 102, 116]
    ///
    /// - Returns: The unicodes for all characters in a string.
    public func unicodeArray() -> [Int] {
        return unicodeScalars.map { Int($0.value) }
    }

    #if canImport(Foundation)
    /// 字符串中所有单词的数组
    ///
    ///		"Swift is amazing".words() -> ["Swift", "is", "amazing"]
    ///
    /// - Returns: The words contained in a string.
    public func words() -> [String] {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
    #endif

    #if canImport(Foundation)
    /// 字符串中单词的数量
    ///
    ///		"Swift is amazing".wordsCount() -> 3
    ///
    /// - Returns: The count of words contained in a string.
    public func wordCount() -> Int {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        let words = comps.filter { !$0.isEmpty }
        return words.count
    }
    #endif

    #if canImport(Foundation)
    /// 空格转横线
    ///
    ///        "Swift is amazing".toSlug() -> "swift-is-amazing"
    ///
    /// - Returns: The string in slug format.
    public func toSlug() -> String {
        let lowercased = self.lowercased()
        let latinized = lowercased.latinized
        let withDashes = latinized.replacingOccurrences(of: " ", with: "-")

        let alphanumerics = NSCharacterSet.alphanumerics
        var filtered = withDashes.filter {
            guard String($0) != "-" else { return true }
            guard String($0) != "&" else { return true }
            return String($0).rangeOfCharacter(from: alphanumerics) != nil
        }

        while filtered.lastCharacterAsString == "-" {
            filtered = String(filtered.dropLast())
        }

        while filtered.firstCharacterAsString == "-" {
            filtered = String(filtered.dropFirst())
        }

        return filtered.replacingOccurrences(of: "--", with: "-")
    }
    #endif

    // 字符串安全提取
    /// SwifterSwift: Safely subscript string with index.
    ///
    ///		"Hello World!"[safe: 3] -> "l"
    ///		"Hello World!"[safe: 20] -> nil
    ///
    /// - Parameter i: index.
    public subscript(safe i: Int) -> Character? {
        guard i >= 0 && i < count else { return nil }
        return self[index(startIndex, offsetBy: i)]
    }

    /// 字符串安全范围提取，包含起点，不包含终点
    ///
    ///		"Hello World!"[safe: 6..<11] -> "World"
    ///		"Hello World!"[safe: 21..<110] -> nil
    ///
    /// - Parameter range: Half-open range.
    public subscript(safe range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }

    /// 字符串安全范围提取，包含起止点
    ///
    ///		"Hello World!"[safe: 6...11] -> "World!"
    ///		"Hello World!"[safe: 21...110] -> nil
    ///
    /// - Parameter range: Closed range.
    public subscript(safe range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }

    #if os(iOS) || os(macOS)
    /// 放到剪贴板中
    ///
    ///		"SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    public func copyToPasteboard() {
        #if os(iOS)
        UIPasteboard.general.string = self
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self, forType: .string)
        #endif
    }
    #endif

    /// 标准驼峰
    ///
    ///		var str = "sOme vaRiabLe Name"
    ///		str.camelize()
    ///		print(str) // prints "someVariableName"
    ///
    public mutating func camelize() {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            self = first + rest
            return
        }
        let rest = String(source.dropFirst())

        self = first + rest
    }

    /// 第一个字符大写
    ///
    ///        "hello world".firstCharacterUppercased() -> "Hello world"
    ///        "".firstCharacterUppercased() -> ""
    ///
    public mutating func firstCharacterUppercased() {
        guard let first = first else { return }
        self = String(first).uppercased() + dropFirst()
    }

    /// 检查字符串是否只包含唯一字符。
    ///
    public func hasUniqueCharacters() -> Bool {
        guard count > 0 else { return false }
        var uniqueChars = Set<String>()
        for char in self {
            if uniqueChars.contains(String(char)) { return false }
            uniqueChars.insert(String(char))
        }
        return true
    }

    #if canImport(Foundation)
    /// 检查字符串是否包含子字符串的一个或多个实例。caseSensitive表示是否区分大小写
    ///
    ///		"Hello World!".contain("O") -> false
    ///		"Hello World!".contain("o", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    #endif

    #if canImport(Foundation)
    /// 字符串中子字符串的计数。
    ///
    ///		"Hello World!".count(of: "o") -> 2
    ///		"Hello World!".count(of: "L", caseSensitive: false) -> 3
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: count of appearance of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    #endif

    /// 检查字符串是否以子字符串结束。
    ///
    ///		"Hello World!".ends(with: "!") -> true
    ///		"Hello World!".ends(with: "WoRld!", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }

    #if canImport(Foundation)
    /// SwifterSwift: Latinize string.
    ///
    ///		var str = "Hèllö Wórld!"
    ///		str.latinize()
    ///		print(str) // prints "Hello World!"
    ///
    public mutating func latinize() {
        self = folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    #endif

    /// 随机字符串
    ///
    ///		String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    public static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }

    /// 翻转
    public mutating func reverse() {
        let chars: [Character] = reversed()
        self = String(chars)
    }

    // swiftlint:disable next identifier_name
    /// 提取字符串根据起始值和长度
    ///
    ///        "Hello World".slicing(from: 6, length: 5) -> "World"
    ///
    /// - Parameters:
    ///   - i: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    /// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World")
    public func slicing(from i: Int, length: Int) -> String? {
        guard length >= 0, i >= 0, i < count  else { return nil }
        guard i.advanced(by: length) <= count else {
            return self[safe: i..<count]
        }
        guard length > 0 else { return "" }
        return self[safe: i..<i.advanced(by: length)]
    }

    // swiftlint:disable next identifier_name
    /// 提取字符串根据起始值和长度，并赋值
    ///
    ///		var str = "Hello World"
    ///		str.slice(from: 6, length: 5)
    ///		print(str) // prints "World"
    ///
    /// - Parameters:
    ///   - i: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    public mutating func slice(from i: Int, length: Int) {
        if let str = slicing(from: i, length: length) {
            self = String(str)
        }
    }

    /// 提取从起始值到结束值
    ///
    ///		var str = "Hello World"
    ///		str.slice(from: 6, to: 11)
    ///		print(str) // prints "World"
    ///
    /// - Parameters:
    ///   - start: string index the slicing should start from.
    ///   - end: string index the slicing should end at.
    public mutating func slice(from start: Int, to end: Int) {
        guard end >= start else { return }
        if let str = self[safe: start..<end] {
            self = str
        }
    }

    // swiftlint:disable next identifier_name
    /// 提取从起始值到结束
    ///
    ///		var str = "Hello World"
    ///		str.slice(at: 6)
    ///		print(str) // prints "World"
    ///
    /// - Parameter i: string index the slicing should start from.
    public mutating func slice(at i: Int) {
        guard i < count else { return }
        if let str = self[safe: i..<count] {
            self = str
        }
    }

    /// 检查字符串是否以子字符串开始。
    ///
    ///		"hello World".starts(with: "h") -> true
    ///		"hello World".starts(with: "H", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }

    #if canImport(Foundation)
    /// 字符串转时间
    ///
    ///		"2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///		"not date string".date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    public func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    #endif

    #if canImport(Foundation)
    /// 删除字符串开头和结尾的空格和新行。
    ///
    ///		var str = "  \n Hello World \n\n\n"
    ///		str.trim()
    ///		print(str) // prints "Hello World"
    ///
    public mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    #endif

    /// 截断字符串(将其截断为给定数目的字符)。
    ///
    ///		var str = "This is a very long sentence"
    ///		str.truncate(toLength: 14)
    ///		print(str) // prints "This is a very..."
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string (default is "...").
    public mutating func truncate(toLength length: Int, trailing: String? = "...") {
        guard length > 0 else { return }
        if count > length {
            self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
        }
    }

    /// 截断的字符串(限制为给定的字符数)。
    ///
    ///		"This is a very long sentence".truncated(toLength: 14) -> "This is a very..."
    ///		"Short sentence".truncated(toLength: 14) -> "Short sentence"
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    /// - Returns: truncated string (this is an extr...).
    public func truncated(toLength length: Int, trailing: String? = "...") -> String {
        guard 1..<count ~= length else { return self }
        return self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
    }

    #if canImport(Foundation)
    /// 将URL字符串转换为可读字符串。
    ///
    ///		var str = "it's%20easy%20to%20decode%20strings"
    ///		str.urlDecode()
    ///		print(str) // prints "it's easy to decode strings"
    ///
    public mutating func urlDecode() {
        if let decoded = removingPercentEncoding {
            self = decoded
        }
    }
    #endif

    #if canImport(Foundation)
    /// 转义字符串
    ///
    ///		var str = "it's easy to encode strings"
    ///		str.urlEncode()
    ///		print(str) // prints "it's%20easy%20to%20encode%20strings"
    ///
    public mutating func urlEncode() {
        if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            self = encoded
        }
    }
    #endif

    #if canImport(Foundation)
    /// 验证字符串是否匹配regex模式。
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    public func matches(pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
    }
    #endif

    /// 填充字符串以使长度参数大小与开始时的另一个字符串相匹配。
    ///
    ///   "hue".padStart(10) -> "       hue"
    ///   "hue".padStart(10, with: "br") -> "brbrbrbhue"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    public mutating func padStart(_ length: Int, with string: String = " ") {
        self = paddingStart(length, with: string)
    }

    /// 通过填充以使长度参数大小与开始时的另一个字符串相匹配，返回一个字符串。
    ///
    ///   "hue".paddingStart(10) -> "       hue"
    ///   "hue".paddingStart(10, with: "br") -> "brbrbrbhue"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    /// - Returns: The string with the padding on the start.
    public func paddingStart(_ length: Int, with string: String = " ") -> String {
        guard count < length else { return self }

        let padLength = length - count
        if padLength < string.count {
            return string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)] + self
        } else {
            var padding = string
            while padding.count < padLength {
                padding.append(string)
            }
            return padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)] + self
        }
    }

    /// 填充字符串以使长度参数大小
    ///
    ///   "hue".padEnd(10) -> "hue       "
    ///   "hue".padEnd(10, with: "br") -> "huebrbrbrb"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    public mutating func padEnd(_ length: Int, with string: String = " ") {
        self = paddingEnd(length, with: string)
    }

    /// SwifterSwift: Returns a string by padding to fit the length parameter size with another string in the end.
    ///
    ///   "hue".paddingEnd(10) -> "hue       "
    ///   "hue".paddingEnd(10, with: "br") -> "huebrbrbrb"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    /// - Returns: The string with the padding on the end.
    public func paddingEnd(_ length: Int, with string: String = " ") -> String {
        guard count < length else { return self }

        let padLength = length - count
        if padLength < string.count {
            return self + string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)]
        } else {
            var padding = string
            while padding.count < padLength {
                padding.append(string)
            }
            return self + padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)]
        }
    }

    /// 移除前缀
    ///
    ///   "Hello, World!".removingPrefix("Hello, ") -> "World!"
    ///
    /// - Parameter prefix: Prefix to remove from the string.
    /// - Returns: The string after prefix removing.
    public func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    /// SwifterSwift: Removes given suffix from the string.
    ///
    ///   "Hello, World!".removingSuffix(", World!") -> "Hello"
    ///
    /// - Parameter suffix: Suffix to remove from the string.
    /// - Returns: The string after suffix removing.
    public func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

}

// MARK: - Initializers
public extension String {

    #if canImport(Foundation)
    /// init: base64
    ///
    ///		String(base64: "SGVsbG8gV29ybGQh") = "Hello World!"
    ///		String(base64: "hello") = nil
    ///
    /// - Parameter base64: base64 string.
    public init?(base64: String) {
        guard let decodedData = Data(base64Encoded: base64) else { return nil }
        guard let str = String(data: decodedData, encoding: .utf8) else { return nil }
        self.init(str)
    }
    #endif

    /// 给定长度的随机数字
    ///
    ///		String(randomOfLength: 10) -> "gY8r3MHvlQ"
    ///
    /// - Parameter length: number of characters in string.
    public init(randomOfLength length: Int) {
        guard length > 0 else {
            self.init()
            return
        }

        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        self = randomString
    }

}

// MARK: - NSAttributedString
public extension String {

    #if canImport(UIKit)
    private typealias Font = UIFont
    #endif

    #if canImport(Cocoa)
    private typealias Font = NSFont
    #endif

    #if os(iOS) || os(macOS)
    /// 加粗
    public var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: Font.boldSystemFont(ofSize: Font.systemFontSize)])
    }
    #endif

    #if canImport(Foundation)
    /// 下划线
    public var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    #endif

    #if canImport(Foundation)
    /// 删除线
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    #endif

    #if os(iOS)
    /// 斜体
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif

    #if canImport(UIKit)
    /// 字体颜色
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    #endif

    #if canImport(Cocoa)
    /// 字体颜色
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: NSColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    #endif

}

// MARK: - Operators
public extension String {

    /// 重复
    ///
    ///        'bar' * 3 -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: string to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }

    /// 重复
    ///
    ///        3 * 'bar' -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: string to repeat.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: Int, rhs: String) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: rhs, count: lhs)
    }

}

#if canImport(Foundation)
// MARK: - NSString extensions
public extension String {

    /// 转NSString
    public var nsString: NSString {
        return NSString(string: self)
    }

    /// 最后的路径成分
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }

    /// 路径后缀
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }

    /// 删除最后的路径成分
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }

    /// 删除后缀
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }

    /// 路径组成数组
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }

    /// 最佳路径成分
    ///
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }

    ///追加路径后缀
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }

}
#endif
