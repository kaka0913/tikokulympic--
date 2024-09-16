import SwiftUI

struct Ranking: View {
    @State var timerHandler:Timer?
        
        var body: some View {
            VStack{
                ZStack{
                    Rectangle()
                        .frame(height: 328)
                        .foregroundColor(.darkred)
                    VStack{
                        Text("残り時間")
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Text("00:00:00")
    //                        .font(.custom("Jersey_25",size:100))//上手くいかない
                            .font(.custom("",size: 100))
                            .foregroundColor(.white)
                        Rectangle()
                            .frame(width: 377,height: 30)
                            .foregroundColor(.lightgray)
                            .cornerRadius(15)
                            .padding(.bottom)
                        Rectangle()
                            .frame(width: 377,height: 30)
                            .foregroundColor(.lightgray)
                            .cornerRadius(15)
                    }
                    
                }
                TextSegmentedControl()
                    ScrollView{
                        Rectangle()
                            .frame(width: 377,height: 78)
                            .foregroundColor(.lightgray)
                            .cornerRadius(40)
                            .padding(.top)
                        Rectangle()
                            .frame(width: 377,height: 78)
                            .foregroundColor(.lightgray)
                            .cornerRadius(40)
                            .padding(.top)
                        Rectangle()
                            .frame(width: 377,height: 78)
                            .foregroundColor(.lightgray)
                            .cornerRadius(40)
                            .padding(.top)
                    }
                    
                
                
                Spacer()
            }
        }
    }

    struct TextSegmentedControl: View {
        @State private var selectedIndex: Int = 0
        
        var body: some View {
            HStack {
                ForEach(0..<2) { index in
                    Text(index == 0 ? "到着者" : "ランキング") // テキストに変更
                        .font(.system(size: 16))
                        
                        .background(self.selectedIndex == index ? Color.darkred : Color.clear)
                        .foregroundColor(self.selectedIndex == index ? Color.white : Color.black)
                        .cornerRadius(15)
                        .onTapGesture {
                            self.selectedIndex = index
                        }
                }
            }
            .padding()
            .background(Color.lightgray)
            .cornerRadius(40)
            .frame(width: 377, height: 60)
        }
    }

#Preview {
    Ranking()
}

