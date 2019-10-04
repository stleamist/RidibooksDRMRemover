import Foundation

private let displayOptionsXMLString = """
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<display_options>
    <platform name="*">
        <option name="specified-fonts">true</option>
    </platform>
</display_options>
"""

struct AppleBooksDisplayOptions {
    static let entryPath = "/META-INF/com.apple.ibooks.display-options.xml"
    static let xmlDocument = try! XMLDocument(xmlString: displayOptionsXMLString)
    static let xmlData = xmlDocument.xmlData(options: .nodePrettyPrint)
}
