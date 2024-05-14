//
//  MapView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI
import MapKit

struct MapView: View {
    //  PROPERTIES
    @ObservedObject var appVM: MapViewModel;
    @State var countryAPI = CountryManager();
    
    @State var countryList: [Country] = [];
    @State var hoveringCountry: Country = emptyCountry;
    @State var isHovering: Bool = false;
    
    init(appVM: MapViewModel) {
        self.appVM = appVM

        //  FETCH ALL COUNTRY
        countryAPI.fetchAllCountries();
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapReader { mapReader in
                Map(position: $appVM.mapCameraPosition) {
                    
                    ForEach(countryList) { country in
                        //  GET Country Location
                        let location =  CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])
                        
                        Annotation("\(country.name.common)", coordinate: location){
                            //  DISPLAY Normal Map Pin if not in Fav List
                            if(appVM.isInFavList(countryCode: country.cca3)){
                                Button{
                                    //  HANDLE Hovering Country Data
                                    if(hoveringCountry.cca3 == country.cca3){
                                        isHovering.toggle();
                                    }
                                    else{
                                        hoveringCountry = country;
                                        isHovering = true;
                                    }
                                } label:{
                                    Image("FavMapPin")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .offset(y: -10)
                                }
                            }
                            //  DISPLAY "FAV" Map Pin if in Fav List
                            else{
                                Button{
                                    //  HANDLE Hovering Country Data
                                    if(hoveringCountry.cca3 == country.cca3){
                                        isHovering.toggle();
                                    }
                                    else{
                                        hoveringCountry = country;
                                        isHovering = true;
                                    }
                                } label:{
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.system(size: 38))
                                        .fontWeight(.regular)
                                        .foregroundStyle([Color.amethyst, Color.yellow].randomElement()!)
                                        .offset(y: -10);
                                }
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
            }
            
            if(isHovering){
                briefInfoBoard;
            }
        }   //  OUTERMOST STACK
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData{
                countryList = safeCountryData;
            }
        }

    }
    
    //  BRIEF INFO Board
    var briefInfoBoard: some View{
        HStack{
            //  FLAG
            AsyncImage(url: URL(string: hoveringCountry.flags.png)){ img in
                img.image?.resizable()
            }
            .frame(width: 60, height: 40)
            .border(.gray);
            
            //  COUNTRY NAME
            Text(hoveringCountry.name.common)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .padding(.horizontal, 5);
            
            Spacer()
            
            //  DISCOVER Button
            Button{
                //  CHANGE VM Data to switch back to "Country Info View"
                appVM.selectedCountry = hoveringCountry.cca3;
                appVM.currentTab = "Info";
            } label:{
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
        )
        .padding(.horizontal);
    }
}

#Preview {
    MapView(appVM: MapViewModel());
}
