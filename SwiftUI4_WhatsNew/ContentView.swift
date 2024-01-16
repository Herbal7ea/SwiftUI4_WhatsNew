import SwiftUI

// All Examples by Paul Hudson
// https://www.youtube.com/watch?v=4obxmYn2AoI

struct ContentView: View {
    var body: some View {
        TapLocation01()
//        GridView01()
//        GridView02()
//        ShareSheet01()
//        Navigation01()
//        Navigation02()
//        Sharing2()
//        Dates01()
//        Search01()
//        Gradients01()
//        Gradients02()
//        ShadowsDrop()
//        ShadowsInner()
//        ShadowsInnerGradient()
//        FlexibileLayouts01()
//        DynamicTypeSize01()
//        SymbolAnimation01()
//        TextLimit01()
//        FontAnimation01()
//        GrowingTextField()
//        FontAnimation02()
//        FontAnimation03()
//        ToggleAll01()
    }
}

// MARK: - ToggleAll01
struct EmailList: Identifiable {
    var id: String
    var isSubscribed = false
}

struct ToggleAll01: View {
    @State private var lists = [
        EmailList(id: "Monthly Updates", isSubscribed: true),
        EmailList(id: "Newsflashes", isSubscribed: true),
        EmailList(id: "Special Offers", isSubscribed: true),
    ]
    
    var body: some View {
        Form {
            Section {
                ForEach($lists) { $list in
                    Toggle(list.id, isOn: $list.isSubscribed)
                }
            }
            Section {
                Toggle(sources: $lists, isOn: \.isSubscribed) {
                    Text("Subscribe to all")
                }
            }
        }
    }
}

// MARK: - FontAnimation03
struct FontAnimation03: View {
    @State private var useRed = false
    
    var body: some View {
        Text("WWDC22")
            .font(.largeTitle.bold())
            .foregroundColor(useRed ? .red : .black)
            .onTapGesture {
                withAnimation {
                    useRed.toggle()
                }
            }
    }
}

// MARK: - FontAnimation02
struct FontAnimation02: View {
    @State private var useBold = false
    @State private var useItalic = false
    
    var body: some View {
        VStack {
            Text("Welcome to SwiftUI 4.0")
                .bold(useBold)
                .italic(useItalic)
            Toggle("Use Bold", isOn: $useBold)
            Toggle("Use Italic", isOn: $useItalic)
        }
        .padding()
        .font(.title)
    }
}

// MARK: - GrowingTextField
struct GrowingTextField: View {
    @State private var bio = ""
    
    var body: some View {
        TextField("Enter your bio", text: $bio, axis: .vertical)
            .textFieldStyle(.roundedBorder)
            .lineLimit(...5)
            .padding()
    }
}

// MARK: - FontAnimation01
struct FontAnimation01: View {
    @State private var useBlack = false
    
    var body: some View {
        Text("Hello, world")
            .font(.largeTitle)
            .fontWeight(useBlack ? .black : .ultraLight)
            .onTapGesture {
                withAnimation {
                    useBlack.toggle()
                }
            }
    }
}

// MARK: - TextLimit01
struct TextLimit01: View {
    var body: some View {
        Text("This is some long text that is limited to a specific line range, so anything beyond that range will cause the text to clip.")
            .lineLimit (3...6)
            .frame (width: 200)
            .font(.title)
    }
}

// MARK: - KeyboardDismiss
struct SymbolAnimation01: View {
    @State private var value = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "aqi.low", variableValue: value)
                Image(systemName: "wifi", variableValue: value)
                Image(systemName: "chart.bar.fill", variableValue: value)
                Image(systemName: "waveform", variableValue: value)
            }
//            .padding([.leading, .trailing], 100)
            
            Slider(value: $value)
        }
        .font(.system(size: 60))
        .foregroundColor(.blue)
        .padding()
    }
}

// MARK: - KeyboardDismiss
struct KeyboardDismiss: View {
    @State private var username = ""
    @State private var bio = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Username", text: $username)
                TextEditor(text: $bio)
                    .frame(height: 400)
                    .border(.quaternary, width: 1)
            }
            .padding(.horizontal)
        }
//        .scrollIndicators(.automatic)
//        .scrollDismissesKeyboard(.interactively)
//        .persistentSystemOverlays(.hidden)
    }
}

// MARK: - DynamicTypeSize01
struct DynamicTypeSize01: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        let layout = dynamicTypeSize <= .xxxLarge ? AnyLayout(VStackLayout())
                                                  : AnyLayout(HStackLayout())
        layout {
            Image(systemName: "1.circle")
            Image(systemName: "2.circle")
            Image(systemName: "3.circle")
        }
        .font(.largeTitle)
    }
}

// MARK: - FlexibileLayouts01
struct FlexibileLayouts01: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        let layout = verticalSizeClass == .regular ? AnyLayout(VStackLayout())
                                                   : AnyLayout(HStackLayout())
        layout {
            Image(systemName: "1.circle")
            Image(systemName: "2.circle")
            Image(systemName: "3.circle")
        }
        .font(.largeTitle)
    }
}

// MARK: - Shadows
struct ShadowsInnerGradient: View {
    var body: some View {
        Circle()
            .fill(.red.gradient.shadow(.inner(color: .black, radius: 20)))
            .padding()
    }
}

struct ShadowsInner: View {
    var body: some View {
        Circle()
            .fill(.red.shadow(.inner(color: .black, radius: 20)))
            .padding()
    }
}

struct ShadowsDrop: View {
    var body: some View {
        Circle()
            .fill(.red.shadow(.drop(color: .black, radius: 20)))
            .padding()
    }
}

// MARK: - Gradients
struct Gradients02: View {
    
    let colors: [Color] = [.blue, .mint, .green, .yellow, .orange, .red, .purple, .indigo]
    
    var body: some View {
        VStack {
            ForEach(colors, id: \.self) { color in
                Rectangle().fill(color.gradient)
            }
        }
    }
}

struct Gradients01: View {
    var body: some View {
        Rectangle().fill(.blue.gradient)
    }
}

// MARK: - Dates 01
struct Dates01: View {
    @State private var dates = Set<DateComponents>()
    @Environment(\.calendar) var calendar
    
    var body: some View {
        VStack {
//            MultiDatePicker("Select your preferred dates", selection: $dates)
            MultiDatePicker("Select your preferred dates", selection: $dates, in: Date.now...)
            Text(summary)
        }
        .padding()
    }
    
    var summary: String {
        dates.compactMap { components in
            calendar.date(from: components)?.formatted(date: .long, time: .omitted)
        }.formatted()
    }
}

// MARK: - Sharing
struct Sharing2: View {
    
    var body: some View {
        let link = URL(string: "https://www.hackingwithswift.com")!
        
        ShareLink(
            item: link,
            preview: SharePreview(
                "Switzerland's flag: it's a big plus",
                image: Image(systemName: "plus")
            )
        )
    }
}

struct Sharing: View {
    @State private var presentedNumbers = NavigationPath()
    
    var body: some View {
        let link = URL(string: "https://www.hackingwithswift.com")!
        
        VStack(spacing: 20) {
            ShareLink(item: link)
            ShareLink(item: link, message: Text("Clearly this is the world's nest Swift site"))
            ShareLink("Learn Swift here", item: link)
            ShareLink(item: link) {
                Label("Learn Swift Here", systemImage: "swift")
            }
        }
    }
}

// MARK: - Navigation
struct Navigation02: View {
    @State private var presentedNumbers = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $presentedNumbers) {
            NavigationLink(value: "Example String") {
                Text ("Tap Me")
            }
            List (1..<50) { i in
                NavigationLink(value: i) {
                    Label("Row \(i)", systemImage: "\(i).circle")
                }
            }
            .navigationDestination(for: Int.self) { i in
                Text("Detail \(i)")
            }
            .navigationDestination (for: String.self) { s in
                Text("String: \(s)")
            }
            .navigationTitle("Navigation")
        }
    }
}

struct Team: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var players: [String]
}

struct Navigation01: View {
    @State private var teams = [
        Team(name: "AFC Richmond", players: ["Dani", "Jamie", "Roy"])
    ]
    
    @State private var selectedTeam: Team?
    @State private var selectedPlayer: String?
    
    var body: some View {
        NavigationSplitView {
            List(teams, selection: $selectedTeam) { team in
                Text(team.name).tag(team)
            }
            .navigationSplitViewColumnWidth(250)
        } content: {
            List (selectedTeam?.players ?? [], id: \.self, selection: $selectedPlayer, rowContent: Text.init)
        } detail: {
            Text (selectedPlayer ?? "Please choose a player.")
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
}

// MARK: - Dates 01
struct ShareSheet01: View {
    @State private var showingCredits = false
    
    var body: some View {
        Button ("Show Credits") {
            showingCredits.toggle()
        }
        .sheet(isPresented: $showingCredits) {
            Text("This app was brought to you from the Apple Developer Center.")
                .presentationDetents([.medium, .large])
        }
    }
}

// MARK: - Grid views
struct GridView01: View {
    var body: some View {
        Grid {
            GridRow {
                Text ("Food")
                Text ("$200")
            }
            GridRow {
                Text ("Rent")
                Text ("$800")
            }
            GridRow {
                Text ("")
                Text ("")
            }
            Divider ()
            
            GridRow {
                Text ("$4600")
                    .gridCellColumns(2)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct GridView02: View {
    var body: some View {
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            GridRow {
                Image (systemName: "xmark")
                Image (systemName: "xmark")
                Image (systemName: "xmark")
            }
            GridRow {
                Image (systemName: "circle")
                Image (systemName: "xmark")
                Image (systemName: "circle")
            }
            GridRow {
                Image (systemName: "xmark")
                Image (systemName: "circle")
                Image (systemName: "circle")
            }
        }
    }
}

// Tap Gesture w/ location
struct TapLocation01: View {
    var body: some View {
        Circle()
            .fill(.red)
            .frame(width: 100, height: 100)
            .onTapGesture { location in
                print("🔴 tapped at \(location)")
            }
    }
}

#Preview {
    ContentView()
}
