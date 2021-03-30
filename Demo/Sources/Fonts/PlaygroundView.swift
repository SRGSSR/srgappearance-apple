//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SRGAppearanceSwift
import SwiftUI

#if os(iOS)

@available(iOS 13, *)
class PlaygroundHostViewController: UIViewController {
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostController = UIHostingController(rootView: PlaygroundView())
        addChild(hostController)
        
        if let hostView = hostController.view {
            hostView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hostView)
            
            NSLayoutConstraint.activate([
                hostView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                hostView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                hostView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                hostView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
        hostController.didMove(toParent: self)
        
        title = NSLocalizedString("Playground", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
    }
    
    @objc func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

@available(iOS 13, *)
struct PlaygroundView: View {
    @State var family: SRGFont.Family = .text
    @State var size: CGFloat = 24
    @State var maximumSize: CGFloat = 70
    @State var weight: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("""
                abcdefghijklmnopqrstuvwxyz
                ABCDEFGHIJKLMNOPQRSTUVWXYZ
                0123456789

                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                """
            ).srgFont(family: family, weight: .init(rawValue: weight), size: size, maximumSize: maximumSize)
            Spacer(minLength: 20)
            
            VStack {
                Picker("Font family", selection: $family) {
                    Text("Text font").tag(SRGFont.Family.text)
                    Text("Display font").tag(SRGFont.Family.display)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Size")
                    Slider(value: $size, in: 8...70)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Maximum size")
                    Slider(value: $maximumSize, in: 8...70)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Weight")
                    Slider(value: $weight, in: -1...1)
                }
            }
            .layoutPriority(1)
        }
        .padding()
    }
}

@available(iOS 13, *)
struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}

#endif
