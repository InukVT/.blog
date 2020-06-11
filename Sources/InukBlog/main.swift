import Foundation
import Publish
import Plot
import InukTheme
import SplashPublishPlugin
import TwitterPublishPlugin

// This type acts as the configuration for your website.
struct InukBlog: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://www.inuk.blog")!
    var name = "Inuk Blog"
    var description = "Tech with a human perspective"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the Inuk Blog theme:
try InukBlog().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .installPlugin(.twitter()),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .inukBlog),
    .generateRSSFeed(including: [.posts]),
    .generateSiteMap()
])
