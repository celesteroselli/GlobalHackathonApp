//
//  ScannerView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import CodeScanner


struct ScannerView: View {
    @Binding var points: Int
    @AppStorage("date") var date: Int = Int(UInt64((Date().timeIntervalSince1970)))
    
    func check_time() -> Bool {
        let now: Int = Int(UInt64((Date().timeIntervalSince1970)))
        if now < (date + 300) {
            return true
            //return to false after debug
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if check_time() {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Success") { response in
                        switch response {
                        case .success(let result):
                            if (result.string) == "Success" {
                                print("Points added!")
                                date = Int(UInt64((Date().timeIntervalSince1970)))
                                points += 1
                                //trigger a modal to pop out saying that points were added
                                
                            }
                        case .failure(let error):
                            //handles error
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    Text("Sorry! To prevent fraud, the scanner is locked out for 5 minutes after scanning a code. Check back in 5 minutes!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
            }
        }.navigationTitle("QR Scanner")
    }
}

//struct ScannerView_Previews: PreviewProvider {
  //  @State var points: Int = 3
  //  static var previews: some View {
  //      ScannerView(points: $points)
  //  }
//}
