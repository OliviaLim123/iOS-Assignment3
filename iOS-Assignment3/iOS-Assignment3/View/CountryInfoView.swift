//
//  CountryInfoView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI
import MapKit

//COUNTRY INFO VIEW Struct
struct CountryInfoView: View {
    
    //STATE to handle the selected country
    @State private var selectedCountry: Country = emptyCountry
        
    //OBSERVED OBJECT for country manager and map view model
    @ObservedObject private var countryAPI: CountryManager
    @ObservedObject var appVM: AppViewModel
    
    //INIT method to get Country By Country Code
    init(countryCode: String, viewModel: AppViewModel) {
        countryAPI = CountryManager()
        self.appVM = viewModel
        //FETCH API BY CODE
        countryAPI.fetchCountryByCode(countryCode: countryCode)
    }
    
    //Another INIT Function to get Country By Name
    init(countryName: String, viewModel: AppViewModel) {
        countryAPI = CountryManager()
        self.appVM = viewModel
        //FETCH API BY NAME
        countryAPI.fetchCountryByName(countryName: countryName)
    }
    
    //COUNTRY INFO VIEW
    var body: some View {
        VStack {
            //WELCOME PART
            HStack {
                //Country Name
                VStack(alignment: .leading) {
                    Text("Welcome to \(selectedCountry.name.common)!")
                        .foregroundStyle(.darkPurple)
                        .font(.custom("MontserratAlternates-SemiBold", size: 24))
                        .tracking(1)
                    Text("\(selectedCountry.name.official)")
                        .foregroundStyle(.textColour)
                        .font(.custom("MontserratAlternates-SemiBold", size: 16))
                        .tracking(1)
                }
                Spacer()
                heartButton
            }
            countryInfo;
            Spacer()
        }
        .padding(.horizontal)
    }
    
    //HEART BUTTON VIEW
    var heartButton: some View {
        //BUTTON Image will be "heart.fill" if in FAV List
        //BUTTON Image will be "heart" if not in FAV List
        Button {
            //TOGGLE Favorite
            if appVM.isInFavList(countryCode: selectedCountry.cca3) {
                appVM.userFavList.removeAll{
                    $0 == selectedCountry.cca3
                }
                //SAVE favourite list to APP STORAGE
                appVM.saveFavList()
            } else {
                appVM.userFavList.append(selectedCountry.cca3)
                //SAVE favourite list to APP STORAGE
                appVM.saveFavList()
            }
        } label: {
            //TOGGLE Heart Icon
            if appVM.isInFavList(countryCode: selectedCountry.cca3) {
                Image(systemName: "heart.fill")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.red);
            } else {
                Image(systemName: "heart")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.black);
            }
        }
    }
    
    //COUNTRY INFO Appearance
    var countryInfo: some View {
        ScrollView {
            VStack {
                //FIRST LINE (FLAG and MAP)
                HStack {
                    //COUNTRY FLAG Appearance
                    VStack(alignment: .leading) {
                        Text("The Flag")
                            .font(.custom("MontserratAlternates-SemiBold", size: 20))
                            .foregroundStyle(.royalPurple)
                            .tracking(0)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        //FLAG IMAGE
                        AsyncImage(url: URL(string: selectedCountry.flags.png)){ image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .padding([.bottom, .horizontal])
                        .frame(width: 170, height: 100)
                    }
                    .background(
                        //INFO BOX background
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.yellowCustom)
                    )
                    Spacer()
                    //MAP Appearance
                    VStack {
                        mapView(country: self.selectedCountry)
                    }   
                    .background(
                        //INFO BOX background
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.yellowCustom)
                    )
                }
                .padding(.vertical, 5)
                
                //SECOND LINE (REGION, SUB-REGION and Capital, Population)
                HStack(alignment: .top) {
                    VStack {
                        //HStack To Stretch Info Box to fill empty space
                        HStack {
                            Spacer()
                        }
                        //REGION Appearance
                        VStack(alignment: .leading) {
                            //TITLES Appearance
                            Text("Region")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .foregroundStyle(.textColour)
                                .tracking(1)
                                .padding(.top, 10)
                                .padding(.bottom, 1)
                            //GET Country Region
                            VStack {
                                Text("\(selectedCountry.region)")
                                    .font(.system(size: 16))
                                    .tracking(0)
                                    .foregroundStyle(.textColour)
                            }
                            .fontDesign(.monospaced)
                            //SUB-REGION Appearance
                            VStack(alignment: .leading) {
                                //TITLES Appearance
                                Text("Sub-Region")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 5)
                                    .padding(.bottom, 1)
                                //GET Country Sub-Region
                                Text("\(selectedCountry.subregion)")
                                    .font(.system(size: 16))
                                    .tracking(0)
                                    .foregroundStyle(.textColour)
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding(.horizontal)
                    .background(
                        //INFO BOX background
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.lightPurple)
                    )
                    Spacer()
                    
                    //CAPITAL & POPULATION Box
                    VStack {
                        //HStack To Stretch Info Box to fill empty space
                        HStack {
                            Spacer()
                        }
                        //CAPITAL Appearance
                        VStack(alignment: .leading) {
                            //TITLES Appearance
                            Text("Capital")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .foregroundStyle(.textColour)
                                .tracking(1)
                                .padding(.top, 10)
                                .padding(.bottom, 1)
                            //GET Country Capitals
                            VStack {
                                VStack(alignment: .leading) {
                                    ForEach(selectedCountry.capital, id: \.self) { cap in
                                        HStack {
                                            Text("\(cap)")
                                                .font(.system(size: 16))
                                                .foregroundStyle(.textColour)
                                                .tracking(0)
                                        }
                                    }
                                }
                            }
                            .fontDesign(.monospaced)
                            
                            //POPULATION Appearance
                            VStack(alignment: .leading) {
                                //TITLES Appearance
                                Text("Population")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 5)
                                    .padding(.bottom, 1)
                                Text("\(selectedCountry.population)")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.textColour)
                                    .tracking(0)
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding(.horizontal)
                    .background(
                        //INFO BOX background
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.lightPurple)
                    )
                }
                .padding(.vertical, 5)
                
                //THIRD LINE (MORE INFO)
                VStack{
                    //TITLE Appearance
                    VStack {
                        Text("More Info")
                            .font(.custom("MontserratAlternates-SemiBold", size: 20))
                            .foregroundStyle(.royalPurple)
                            .tracking(1)
                            .padding(.top, 10)
                            .padding(.bottom, 1)
                    }
                    .padding(.horizontal)
                    //INFO AREA Appearance
                    VStack {
                        //CURRENCY Box Appearance
                        VStack(alignment: .leading) {
                            Text("Currency")
                                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                .foregroundStyle(.textColour)
                                .tracking(1)
                                .padding(.top, 10)
                                .padding(.bottom, 1)
                            //GET Country Currency
                            VStack {
                                ForEach(selectedCountry.currencies.sorted(by: { $0.key < $1.key }), id: \.key) { currency in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("\(currency.value.name)")
                                                .font(.system(size: 16))
                                                .foregroundStyle(.textColour)
                                                .tracking(0)
                                            Spacer()
                                            Text("(\(currency.value.symbol))")
                                                .font(.system(size: 20))
                                                .foregroundStyle(.textColour)
                                                .tracking(0)
                                        }
                                    }
                                    .padding(.bottom, 5)
                                }
                            }
                            .fontDesign(.monospaced)
                            .padding(.bottom, 5)
                        }
                        .padding(.horizontal)
                        .background(
                            //INFO BOX background
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.lightPurple)
                        )
                        Spacer()
                        //BORDER and Language Appearance
                        HStack {
                            //BORDER Appearance
                            VStack(alignment: .leading) {
                                Text("Borders")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 10)
                                    .padding(.bottom, 1)
                                //GET Country's Border Neighbors
                                ScrollView {
                                    ForEach(selectedCountry.borders, id: \.self) { neighborCountry in
                                        HStack {
                                            Text("\(neighborCountry)")
                                                .foregroundStyle(.textColour)
                                                .padding(.bottom, 5)
                                            Spacer()
                                        }
                                    }
                                }
                                .font(.system(size: 16))
                                .tracking(0)
                                .frame(maxWidth: 120, maxHeight: 200)
                                .padding(.bottom, 5)
                            }
                            .fontDesign(.monospaced)
                            .padding(.horizontal)
                            .background(
                                //INFO BOX background
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.lightPurple)
                            )
                            Spacer()
                            //LANGUAGE Appearance
                            VStack(alignment: .leading) {
                                Text("Language")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .foregroundStyle(.textColour)
                                    .tracking(1)
                                    .padding(.top, 10)
                                    .padding(.bottom, 1)
                                //GET Country's Border Neighbors
                                ScrollView {
                                    //GET Country Languages
                                    ForEach(selectedCountry.languages.sorted(by: { $0.key < $1.key }), id: \.key) { lang in
                                        HStack {
                                            Text("\(lang.value)")
                                                .foregroundStyle(.textColour)
                                                .padding(.bottom, 5)
                                            Spacer()
                                        }
                                    }
                                }
                                .font(.system(size: 16))
                                .tracking(0)
                                .frame(maxHeight: 200)
                                .padding(.bottom, 5)
                            }
                            .fontDesign(.monospaced)
                            .padding(.horizontal)
                            .background(
                                //INFO BOX background
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.lightPurple)
                            )
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding(.bottom, 10)
                .background(
                    //INFO BOX background
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.yellowCustom)
                )
                Spacer()
            }
            .onReceive(countryAPI.$country){countryData in
                if let safeCountry = countryData{
                    selectedCountry = safeCountry
                }
            }
        }
    }
    
    //METHOD for MAP VIEW
    func mapView(country: Country) -> some View {
        //GET Country Lat and Lng Data to Display MAP View
        @State var region = MKCoordinateRegion (center: CLLocationCoordinate2D (latitude: country.latlng[0], longitude: country.latlng[1]), span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))
        
        //SET Map View PROPERTIES based on Lat and Long data above
        let countryCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])
        @State var mapCameraPosition: MapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: countryCoordinates, distance: 3500000))
        
        return MapReader { mapReader in
            Map(position: $mapCameraPosition) {
                
                //  GET Country Location
                let location =  CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])
                
                Annotation("\(country.name.common)", coordinate: location){
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 32))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.pink)
                        .offset(y: -10);
                }
            }
            .mapStyle(.standard(elevation: .realistic))
        }
    }
}

#Preview {
    CountryInfoView(countryCode: "vnm", viewModel: AppViewModel())
}
