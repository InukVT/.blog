---
title: EnvironmentObjects and UIDocumentPicker
slug: environmentobjects-and-document-picker
date: 2020-05-26 11:27
date_updated: 2020-05-26T11:27:28.000Z
tags: swift, swiftui, iOS, coding, how to
description: Need to access EnvironmentObjects in UIDocumentPicker or any other UIKit view? Read more to know how I did it.
---

For my current project, I needed to have some UIKit code which manipulated an `@EnvironmentObject`, but unfortunately UIKit doesn't know aboutthis property wrapper, I had to find an alternative. The `@EnvironmentObject` in question, was to be manipulated by a `UIDocumentPickerDelagate`'s `documentPicker(_:)`, this specific method gets called when a file gets picked, and I wanted to tell my `@EnvironmentObject` that a file was picked.

My solution is to bring the handling of selected documents up into SwiftUI. For starters, let me show you the simplest part of my code, the picker delegate:

```swift
typealias URLS = ([URL]) -> ()
typealias voidFunc = () -> ()

class DocumentDelagate: UIView ,UIDocumentPickerDelegate {
    var onOpen: URLS = { print($0) }
    var onCancel: voidFunc = {}
    
    func documentPicker(_ controller: UIDocumentPickerViewController,
                        didPickDocumentsAt urls: [URL]) {
        onOpen(urls)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        onCancel()
    }
    
}

```

It's a simple subclass of `UIView` and `UIDocumentPickerDelagate`. The reason I subclass `UIView` is so I don't have to add a lot of protocol stubs from `NSProtocol`. This unfortunately means making a custom init is a bit difficult, as such I gave my callbacks default values, but fret not, this is changed in my UIKit SwiftUI wrapper.
```swift
struct DocumentPickerController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DocumentPicker
    let picker: UIViewControllerType
    
    init(documentTypes: [String],
         onOpen:  @escaping URLS,
         onCancel: @escaping voidFunc) {
        self.picker = UIViewControllerType(documentTypes: documentTypes, in: .open)
        let delagate = DocumentDelagate()
        delagate.onOpen = onOpen
        delagate.onCancel = onCancel
        picker.documentDelegate = delagate
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        picker
    }
    
}
```

The type alias is for quicker iterations and testing between needing to supclass the pickerview or not. As I have a reference to the delagate in the supclassed document picker, I only need it in `init` so I can mmodify the callback variables. And then I instantiate the supclassed document picker, as well as return the picker in `makeUIViewController(context:)`, as you can see, I've still yet to bring in `@EnvironmentObject`, that'll come later. The subclassed document picker is basic, looks as following:
```swift
class DocumentPicker: UIDocumentPickerViewController {
    var documentDelegate: UIDocumentPickerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self.documentDelegate
    }
}
```

The supclassed document picker is not interesting. All it does is keep a strong instance of the delagate and assign it to its superclass's weak instance of the delagate. This is so the delagate is not deallocated when needed. And to finish it all off, I wrap this view into a neat little SwiftUI `View` which looks as following:
```swift
struct DocumentPickerButton<Label: View>: View {
    @State
    var showPicker = false
    
    private let pickerController: DocumentPickerController
    private let onOpen: URLS
    private let onCancel: voidFunc
    private let view: () -> (Label)
    
    init(documentTypes: [String],
         onOpen: @escaping ([URL]) -> (),
         onCancel: @escaping () -> () = {},
         @ViewBuilder view: @escaping () -> (Label))
    {
        self.documentTypes = documentTypes
        self.onOpen = onOpen
        self.onCancel = onCancel
        self.view = view
    }
    
    var body: some View {
        Button(action: {self.showPicker.toggle() }) {
            view()
        }
        .sheet(isPresented: self.$showPicker) {
            DocumentPickerController(documentTypes: self.documentTypes,
                                     onOpen: self.onOpen,
                                     onCancel: self.onCancel)
        }
    }
}
```

This looks a bit complicated but, but let's break it down a bit. The init takes the callback, and as not everyone needs have an `onCancel` handler, I made a default empty implementation. Reason I didn't instantiate the picker here, is because I don't want the picker view polluting in the background, it might not matter but alas. The button is an action, which takes the `view` from the initializer as label. I then spawn the document picker, when the button is pressed. The document browser view from the picker is in a sheet, this is to closer match the look and behaviour from UIKit, you can of course have the browser in any view you prefer.

And I promised some `@EnvironmentObject`, how did I use that? Once the document picker view is a SiftUI view, I can bring in the object like I usually would, and the way I call `DocumentPickerButton` in my app, looks a little like this:
```swift
struct ContentView: View {
    @EnvironmentObject var player: Player
    var body: some View {
        NavigationView {
            List {
                ForEach(player.queue, id: \.self) { song in
                    SongCellView(song: song)
                }
            }.onAppear {
                UITableView.appearance()
                    .separatorStyle = .none
            }
            .navigationBarTitle(Text("Song"))
            .navigationBarItems(trailing: 
                DocumentPickerButton(documentTypes: ["public.mp3"],
                                     onOpen: self.openSong){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
            } )
        }
        
    }
    
    func openSong (urls: [URL]) -> () {
        print("Reading URLS")
        urls.forEach { url in
            guard url.startAccessingSecurityScopedResource() else {
                print("Failed to open the file")
                return
            }
            print(url)
            defer { url.stopAccessingSecurityScopedResource() }
            
            guard let bookmark = try? url.bookmarkData() else {
                return
            }
            
            let defaults = UserDefaults.standard
            
            var array = defaults.array(forKey: "Songs") as? [Data]
            array?.append(bookmark)
            defaults.set(array, forKey: "Songs")
            
            self.player.song = .AVPlayer(.init(url: url))
        }
    }
}
```

And this is how I brought `@EnvironmentObject` into the world of UIKit.
