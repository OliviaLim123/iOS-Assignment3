//
//  MapView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI
import MapKit

struct MapView: View {
    
    //OBSERVED OBJECT of app view model
    @ObservedObject var appVM: AppViewModel
    
    //STATE Properties
    @State var countryAPI = CountryManager()
    @State var countryList: [Country] = []
    @State var hoveringCountry: Country = emptyCountry
    @State var isHovering: Bool = false
    
    //INIT method to initialise
    init(appVM: AppViewModel) {
        self.appVM = appVM
        //FETCH all countries
        countryAPI.fetchAllCountries()
    }
    
    //MAP VIEW
    var body: some View {
        ZStack(alignment: .top) {
            MapReader { mapReader in
                Map(position: $appVM.mapCameraPosition) {
                    ForEach(countryList) { country in
                        //GET Country Location
                        let location =  CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])
                        Annotation("\(country.name.common)", coordinate: location) {
                            //DISPLAY Normal Map Pin if not in Fav List
                            if appVM.isInFavList(countryCode: country.cca3) {
                                Button {
                                    //HANDLE Hovering Country Data
                                    if hoveringCountry.cca3 == country.cca3 {
                                        isHovering.toggle()
                                    } else {
                                        hoveringCountry = country
                                        isHovering = true
                                    }
                                } label: {
                                    if hoveringCountry.cca3 == country.cca3 && isHovering {
                                        Image("FavMapPin")
                                            .resizable()
                                            .renderingMode(.template)
                                            .tint(.red)
                                            .frame(width: 80, height: 80)
                                            .offset(y: -10)
                                    } else {
                                        Image("FavMapPin")
                                            .resizable()
                                            .renderingMode(.template)
                                            .tint(.red.opacity(0.5))
                                            .frame(width: 80, height: 80)
                                            .offset(y: -10)
                                    }
                                }
                            //DISPLAY "FAV" Map Pin if in Fav List
                            } else {
                                Button {
                                    //HANDLE Hovering Country Data
                                    if hoveringCountry.cca3 == country.cca3 {
                                        isHovering.toggle()
                                    } else {
                                        hoveringCountry = country
                                        isHovering = true
                                    }
                                } label: {
                                    if hoveringCountry.cca3 == country.cca3 && isHovering {
                                        Image(systemName: "mappin.and.ellipse")
                                            .font(.system(size: 38))
                                            .fontWeight(.regular)
                                            .foregroundStyle(Color.amethyst)
                                            .offset(y: -10)
                                    } else {
                                        Image(systemName: "mappin")
                                            .font(.system(size: 38))
                                            .fontWeight(.regular)
                                            .foregroundStyle(Color.amethyst.opacity(0.5))
                                            .offset(y: -10)
                                    }
                                }
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
            }
            if isHovering {
                briefInfoBoard
            }
        }
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData {
                countryList = safeCountryData
            }
        }
    }
    
    //BRIEF INFO Board
    var briefInfoBoard: some View {
        HStack {
            //COUNTRY FLAG
            AsyncImage(url: URL(string: hoveringCountry.flags.png)) { img in
                img.image?.resizable()
            }
            .frame(width: 60, height: 40)
            .border(.gray)
            //COUNTRY NAME
            Text(hoveringCountry.name.common)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .padding(.horizontal, 5)
            Spacer()
            //DISCOVER Button
            Button {
                //CHANGE VM Data to switch back to "Country Info View"
                appVM.selectedCountry = hoveringCountry.cca3
                appVM.currentTab = "Info"
            } label: {
                Text("Discover")
                    .font(.system(size: 16))
                    .padding(10)
                    .foregroundStyle(.royalPurple)
                    .fontWeight(.semibold)
                    .fontDesign(.monospaced)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.sweetCorn)
                    )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.lightPurple)
                .overlay(
                    //The shape of the overlay should match the element
                    RoundedRectangle(cornerRadius: 10)
                        //Border color and width
                        .stroke(Color.gray, lineWidth: 4)
                        //Blur the border to create a soft shadow effect
                        .blur(radius: 3)
                        //Offset of the shadow
                        .offset(x: 0, y: 2)
                        .mask(
                            //Mask using the same shape as the element
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)
                                )
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                )
        )
        .padding(.horizontal)
    }
}

#Preview {
    MapView(appVM: AppViewModel())
}
