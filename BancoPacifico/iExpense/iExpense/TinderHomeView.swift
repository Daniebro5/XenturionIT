import SwiftUI

struct TinderHomeView: View {
    var body: some View {
        VStack {
            HeaderView()
            BackgroundImageView()
            Spacer()
            TabBarView()
        }
    }
}

struct TabBarView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "flame.fill")
                .foregroundStyle(.pink)
            Spacer()
            Image(systemName: "doc.text.magnifyingglass")
            Spacer()
            Image(systemName: "star.fill")
            Spacer()
            Image(systemName: "message.badge.circle")
            Spacer()
            Image(systemName: "person.crop.circle")
            Spacer()
        }
        .font(.title)
    }
}



struct HeaderView: View {
    var body: some View {
        HStack {
            
            Image(systemName: "flame.fill")
                .foregroundStyle(.red)
            
            Text("tinder")
                .font(.title)
                .foregroundStyle(.red)
            
            Spacer()
            
            Image(systemName: "bell.fill")
                .foregroundStyle(.gray)
            
            Image(systemName: "slider.horizontal.2.square")
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 16)
    }
}



struct BackgroundImageView: View {
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "https://picsum.photos/400"))
            VStack {
                Spacer()
                HStack {
                    VStack {
                        Text("Paola 18")
                            .font(.title3)
                        
                        HStack {
                            Image(systemName: "location")
                            Text("6 km away")
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.bottom, 36)
                    .padding(.leading, 16)
                    
                    Spacer()
                }
                .background(Color.black)
            }
        }
    }
}

#Preview {
    TinderHomeView()
}
