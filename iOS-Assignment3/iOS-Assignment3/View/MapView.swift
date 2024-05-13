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
    @ObservedObject var appVM: AppViewModel;
    @State var countryAPI = CountryManager();
    
    @State var countryList: [Country] = [];
    
    let country = emptyCountry;
    
    
    init(appVM: AppViewModel) {
        self.appVM = appVM

        //  FETCH ALL COUNTRY
        countryAPI.fetchAllCountries();
    }
    
    
    var body: some View {
        VStack {
            MapReader { mapReader in
                Map(position: $appVM.mapCameraPosition) {
                    
                    ForEach(countryList) { country in
                        //  GET Country Location
                        let location =  CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])
                        
                        Annotation("\(country.name.common)", coordinate: location){
                            //  DISPLAY Normal Map Pin if not in Fav List
                            if(appVM.isInFavList(countryCode: country.cca3)){
                                Image("FavMapPin")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .offset(y: -10)
                            }
                            //  DISPLAY "FAV" Map Pin if in Fav List
                            else{
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 38))
                                    .fontWeight(.regular)
                                    .foregroundStyle([Color.mauve, Color.sweetCorn, Color.mint].randomElement()!)
                                    .offset(y: -10)
                            }
                        }
                    }
                }
                .mapStyle(.hybrid(elevation: .flat))
                .onTapGesture { tap in
                    if let tapCoordinate = mapReader.convert(tap, from: .local) {
                        Task {
//                            await viewModel.addMapAnnotation(coordinate: tapCoordinate)
                        }
                        print("Continuing program")
                    }
                }
            }
        }   //  OUTERMOST STACK
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData{
                countryList = safeCountryData;
            }
        }

    }
}

#Preview {
    MapView(appVM: AppViewModel());
}
